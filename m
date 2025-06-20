Return-Path: <linux-pm+bounces-29157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF870AE1925
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 12:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE76F3BCB68
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D949E251793;
	Fri, 20 Jun 2025 10:38:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4436E23AB8A
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415901; cv=none; b=EnHHQtrBdVD92FVg0BiQwErBep3PeZcqVzLK7dn6gJsBK4E2qXmZ8EzRy3HgVvnvv45Az20AKoKA4DpXu8S9mO4gx1RGQFHGTnwe7B84Yt3b+0XRWnNMSYMQ0j0ETw7yxdlMoGmwokApDz7E03Q890CYYeLNL3KXVouMADzIhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415901; c=relaxed/simple;
	bh=MD+4KS18Qn+2H67aXv6OFtdHYg6Fe36O3JvxDOEiHLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uk6xz8uUSVP8k7xGkci3CEEOAl5AzoZu2Tmqda4N2gCaWpTZI1Y9Hzm61ThqS86Z2JgN3fYG7MJXgtr2KD0u+W0YSsvtMbz04nSvhfgsFhIUXo+ZzyMMI/ddomGLERc+YdTtbBGIF77Pz8PemxzxGikZDOtFOzdySmtBSoZX4Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC420176A;
	Fri, 20 Jun 2025 03:37:52 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 366623F58B;
	Fri, 20 Jun 2025 03:38:11 -0700 (PDT)
Date: Fri, 20 Jun 2025 11:38:08 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: =?utf-8?B?6buE5bCR5rOi?= <huangshaobo2075@phytium.com.cn>
Cc: <linux-pm@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<deepthi@linux.vnet.ibm.com>, <khilman@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: Subject: [cpuidle] Limitation: cannot model asymmetric C-state
 latencies on big.LITTLE SoCs
Message-ID: <20250620-agate-beluga-of-wonder-e603ce@sudeepholla>
References: <5d7534c.5492.1977796c43a.Coremail.huangshaobo2075@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d7534c.5492.1977796c43a.Coremail.huangshaobo2075@phytium.com.cn>

On Mon, Jun 16, 2025 at 03:14:18PM +0800, 黄少波 wrote:
> 
> 信息安全声明：本邮件包含信息归发件人所在组织所有,发件人所在组织对该邮件拥有所有权利。请接收者注意保密,未经发件人书面许可,不得向任何第三方组织和个人透露本邮件所含信息。
> Information Security Notice: The information contained in this mail is
> solely property of the sender's organization.This mail communication is
> confidential.Recipients named above are obligated to maintain secrecy and
> are not permitted to disclose the contents of this communication to others.

This is not possible on the list, so I am just deleting all your emails.

-- 
Regards,
Sudeep

