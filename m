Return-Path: <linux-pm+bounces-8513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9128D7D14
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 10:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9DA1C20A08
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 08:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5A85A11D;
	Mon,  3 Jun 2024 08:13:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B6557880;
	Mon,  3 Jun 2024 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402434; cv=none; b=tOJ70BLXPmc1RwaVXlqRpwZHjA/L4KaTF3tYSOJzH9XWAMbNtFWwkRg43kDwEi8AV4Etef6rnD1mNTsJ//01I4xf4Mujc+LkblR14MsIu8ZHyg0SvcJ3aHzfFCegdppVVDTPZG83BQsEdtKe22Q8tgUpSDqtUazjCm7esTbMnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402434; c=relaxed/simple;
	bh=pc1bt4zAadgnjFsSe5/HFZnbWwMdyN9oYQuKMuUsAgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IKUqb2kSe6Mw+n9VXTuRiTByZf9eAieXVVM2AJxU6RixvB5fYJWx/7HBlbx30CdSl9DfzzkZETNVwMBcXsqcuvop2L/2DRXxnVgnFG0Tj8uQUfPSprq3C8FoGfBTu8YFTgmFRVD8PA0pQQVqvOsqDDs/HrCOM/cdBGDzI56HtXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B3A81042;
	Mon,  3 Jun 2024 01:14:16 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B526F3F792;
	Mon,  3 Jun 2024 01:13:50 -0700 (PDT)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com
Cc: ionela.voinescu@arm.com,
	vanshikonda@os.amperecomputing.com,
	sumitg@nvidia.com
Subject: [PATCH 0/1] cpufreq: Move arch_freq_get_on_cpu to cpuinfo_cur_freq
Date: Mon,  3 Jun 2024 09:13:30 +0100
Message-Id: <20240603081331.3829278-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

The CPUFreq core exposes, via sysfs, number of attributes, with cpuinfo_cur_freq
and scaling_cur_freq being one of those. The first one, cpuinfo_cur_freq is
supposed to provide current frequency of a given CPU, with an expectation,
that this one will be the one that hardware actually runs at. The second one,
scaling_cur_freq, is likewise suppose to show current frequency,though this
time, it might not actually reflect the frequency values as seen by the hardware,
as it will, in most cases, provide the last frequency requested.
For some architectures though, the scaling_cur_freq might be given higher
precision, still with no guarantee to match the exact CPU frequency. 
This though adds a bit of confusion as it deviates from the attribute's
original meaning: last requested frequency.
Currently the higher precision of the CPU frequency provided via scalin_cur_freq
for x86 is being achieved by utilizing APERF/MPERF registers, based on values
of which, an average frequency (over 20ms time-window) is being determined.
With the added support for AMU-based FIE for ARM, similar functionality can be
([1]) alike exposed through arch_freq_ge_on_cpu. So far so good.
Things get slightly complicated/confusing though when attempting to advertise
that via related CPUFreq sysfs attributes. Relying on hardware counters to
determine the CPU frequency is, in fact, a hardware feedback and as such,
intuitively, should be wired with cpuinfo_cur_freq, even despite the fact that
both implementations (of arch_freq_ge_on_cpu) provide an average instead of
an instant view on current frequency. For that to happen though,
arch_freq_ge_on_cpu (and hw feedback for that matter) should be removed from
scaling_cur_freg. Having both relying on arch_freq_ge_on_cpu is a no go, as
there should be a way to distinguish current vs expected frequency.
Now, as straightforward as that may seem, the change might cause some
disruption for user-space tools that might be relying on scaling_cur_freq
to provide that extra precision, one that APERF/MPERF bring. For those,
scaling_cur_freq may retain its use of arch_freq_ge_on_cpu for cases when
cpuinfo_cur_freq is not exposed.
The change seems unavoidable though: this way or another.
Any ideas on ow to handle it better are more than welcomed.

Related discussions:
[1] https://lore.kernel.org/all/20240417093848.1555462-1-beata.michalska@arm.com/
    (updated version on the way)
[2] https://lore.kernel.org/all/ZIwx+4zVzgKGLcS3@e120325.cambridge.arm.com/
[3] https://lore.kernel.org/all/20240520091853.tbxzoolqh5tgzg7t@vireshk-i7/

Beata Michalska (1):
  cpufreq: Rewire arch specific feedback for cpuinfo/scaling_cur_freq

 drivers/cpufreq/cpufreq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1


