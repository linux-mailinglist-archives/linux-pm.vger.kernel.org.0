Return-Path: <linux-pm+bounces-43431-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIn3LAe7pWnNFQAAu9opvQ
	(envelope-from <linux-pm+bounces-43431-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 17:29:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C41DCCE9
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 17:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14328302FFD9
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF01D41C0D4;
	Mon,  2 Mar 2026 16:29:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53263E9F7B;
	Mon,  2 Mar 2026 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468958; cv=none; b=BbCc5VQTG2Te5yMilrmNVqvfCHz5KXtDCjr85DK39J5ifcnKr2idxmqYVQ7mdjAfBRl1KVHIKtx1I/MIjpzUkee/MbrDrINM4Z6aAHj+OgJQB9E5AxQ/yskdb/NCTADakksGS/Dx3RwbbD377ZzUvirfkfGyNzfusw9A6ojk/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468958; c=relaxed/simple;
	bh=pjSZJqnhsp/YZkKPS1oMF68Uu/54f4eKu2/Po/9s8JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4NvQvD95ZR9pKrVr9rlJMwuzAPVoHBxcQRHP5CH7Oi8sGed8mHV8LDJix1KGNlvjxAK6e8CpxkSiNBSfqgVbCleYGzTkd1wVAFivrGUZfcMvGmWV135tFG/+6SaLkmxkZDof+R2fqJPyUqPXANpNLEyLpfUvbfWeMIX/aWLCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C723C2BC86;
	Mon,  2 Mar 2026 16:29:14 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ilia Lin <ilia.lin@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/7] of: Add and use of_machine_get_match() helper
Date: Mon,  2 Mar 2026 17:29:04 +0100
Message-ID: <cover.1772468323.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 594C41DCCE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43431-lists,linux-pm=lfdr.de,renesas];
	DMARC_NA(0.00)[glider.be];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,gmail.com,vger.kernel.org,glider.be];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,linux-pm@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.777];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,glider.be:mid,linux-m68k.org:email]
X-Rspamd-Action: no action

	Hi all,

Currently, there are two helpers to match the root compatible value
against an of_device_id array:
  - of_machine_device_match() returns true if a match is found,
  - of_machine_get_match_data() returns the match data if a match is
    found.
However, there is no helper that returns the actual of_device_id
structure corresponding to the match, leading to code duplication in
various drivers.  Worse, with the plan to make of_root private[1], more
open-coded users may appear.

Hence this series adds a new helper of_machine_get_match(), which
returns the match entry, and converts several drivers to make use of it.
Note that the new wrapper comes at no cost (binary size-wise),
as the variant returning bool can be a trivial inline wrapper.

One could argue we don't even need the variant that returns bool,
as
    "if (of_machine_device_match(...))" and
    "if (of_machine_get_match(...))",
and
    "if (!of_machine_device_match(...))" and
    "if (!of_machine_get_match(...))"
are equivalent.

The return type only matters when assigning to or returning an explicit
type, like in drivers/soc/tegra/common.c:

    bool soc_is_tegra(void)
    {
	    return of_machine_device_match(tegra_machine_match);
    }

Only the Renesas driver patch was tested on actual hardware.

Thanks for your comments!

[1] "[PATCH v2 0/9] soc: remove direct accesses to of_root from
     drivers/soc/"
    https://lore.kernel.org/20260223-soc-of-root-v2-0-b45da45903c8@oss.qualcomm.com/

Geert Uytterhoeven (7):
  of: Add of_machine_get_match() helper
  of: Convert to of_machine_get_match()
  cpufreq: airoha: Convert to of_machine_get_match()
  cpufreq: qcom-nvmem: Convert to of_machine_get_match()
  cpufreq: ti-cpufreq: Convert to of_machine_get_match()
  soc: qcom: pd-mapper: Convert to of_machine_get_match()
  soc: renesas: Convert to of_machine_get_match()

 drivers/cpufreq/airoha-cpufreq.c     |  7 +------
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 16 ++--------------
 drivers/cpufreq/ti-cpufreq.c         | 12 +-----------
 drivers/of/base.c                    | 20 ++++++--------------
 drivers/soc/qcom/qcom_pd_mapper.c    |  8 +-------
 drivers/soc/renesas/renesas-soc.c    |  2 +-
 include/linux/of.h                   | 11 ++++++++---
 7 files changed, 20 insertions(+), 56 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

