Return-Path: <linux-pm+bounces-24822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38C6A7BEDF
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 16:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE103B8AAA
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 14:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFB71EFFBD;
	Fri,  4 Apr 2025 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bab2Mxno"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B111EBFF0;
	Fri,  4 Apr 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743776241; cv=none; b=TR/lp18zmSLa1WAsKvF1fD8H7jNkmlN0cwZC6JQtoP0UadT7TQFg8iAzeZg0YfOddCIu6YCe3tfK/nB6vBrObJ/pErYXtYuUB7quXqmZrfdEski9bZ0eb0H3h2tYQl6s/SweR14QoGvRXpVlUy0F31/Fk/rsln1RSsZqUtgff2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743776241; c=relaxed/simple;
	bh=+1U1cWovTA5uTsLrg02/upXbC5wZqI1dP4zYTSOQYpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=awJ8K7X5Vk+NJcFRPxQYWKO9w3bbTttWXjmipS5hnc47Y/JRbADKgwlw60jKtIMkiUtRWwqPBEUb/ImAXQvMsfTpDNMUgbd852HeVYruzM1I1Qcoisrg3RkKgEiQ4/bvQOFxNXNxmkoBUq+AEk9lpZyAtPDFagJiu3Tss4UX/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bab2Mxno; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30332dfc820so2061136a91.2;
        Fri, 04 Apr 2025 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743776238; x=1744381038; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJkY/rj+UDur6IhWIRiqvOf7fRgwOlEqOQiYwibJQko=;
        b=Bab2MxnoA8eGrTroJ002+2kDriZKHdhY6pdGIIApXqGFi/L8oCFgP78jCRJhlNrS7k
         tLghWAkzpHNC2Ngl4alNQA6IqbOvHVljjrE5ESDUI8EKNgJMA54KzgQrNtoLpa6FIgVp
         y10kr7gXp5HWcFEPFfdrVJlyHN8tRelV1nrEb0BTXJD2zRpC16szbJ88yWm/JEmR/+rL
         6i3BmxZwH1PR2nqMfM/e2SJFtehxug5Tyri1CmPkK+0ZuM+jfERZP83zw8qDIWth9Yab
         MVLdoexlL84nKZ2VLmhFeODcAw128uNn+qtAvl/5QOwmpICunZ2KYRT2YnwVnDkb/O7b
         wjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743776238; x=1744381038;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJkY/rj+UDur6IhWIRiqvOf7fRgwOlEqOQiYwibJQko=;
        b=aF9tY2LR+rBsCTcyCX2LDarHtqYmB9xmPg64Jmzu/8gdIgBpokXS2x/PtWuCRjUeub
         TnSOEDs7lCgkU0csqFlRAoTxQA/E01Z0jxEWeYYAMJ6OgGs6pqL5ClYySH78msBwzonh
         EdLuaCpWKQafA6F19Fx9/RhNTEdjDnJPHQ0UBhNkJ3SEow3oD6vRTlWif5WJEy7a4CB0
         2CAB43QrUnk5AdBpvElDNBfxX+PPzSUlJGK0EZj5lQErS7x0/FsP2m9InkZAqGs16Jo7
         y9c69/V7P3cZGfK1k5obgtz/8I3ytbAL8muAToHuOS+tMS2jTYnTlG5yqrcqV+yT8tN6
         zMsA==
X-Forwarded-Encrypted: i=1; AJvYcCXdY9vpxexGEjUPeICAlGQIBxWmX14CcSG1VCxjQCDffBBzaKXl3WvYO+s7HVnDUnK19aEcmx7j/BFyjyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMU+VC1HuKicwMl7G88YdlKTh4jJb2KhOGSedxQQq/+TYrcmX
	O3mryVv4vqNKbslcrwnVvuoaJH/PXssXl1mjzHEFocrW5yvXKKEQfIcy1pqy
X-Gm-Gg: ASbGncvZKQmfPZZoaER9+n1pY7xPNwMfxHCtXYPUWVbyGdUJK1odXFKyEVR36OExczo
	olNLJk6rnOq2k5EQNztQTEuMp7tS4YxCrLxaJSjmoaLDmWGmjf7xk/y9JmObFl81BUab7QD+6Ih
	LmCBPZuLOfep2G5bFkPZzPplaMH7pbG8gU5nhNpq763kDplxvhaNqtWRpqfoNOgbop6e+UCfnsw
	iraM0YmxmmdToiQJaZjlcnQ7vg6NgKZsMt9WAvU1FFJC8RTuH+nay6/0a0fLczVhB5z6GIRpbLx
	m5q2RsIaieP7+DLjHVgHfjy6YX7f4FpKt1lmCb5O7tI=
X-Google-Smtp-Source: AGHT+IGq9BLsszWtOE+3T1GWMl1g2khKbvr87Eb9IDtheXW5uB6Qt8lknEwKp1TWBl0CEPIqeeafWA==
X-Received: by 2002:a17:90b:524f:b0:2ea:712d:9a82 with SMTP id 98e67ed59e1d1-306a498bfbbmr5106652a91.29.1743776238250;
        Fri, 04 Apr 2025 07:17:18 -0700 (PDT)
Received: from hiago-nb ([2804:1b3:a7c2:fdb9:802:4e79:d42a:3b39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057ca1f40fsm3693825a91.4.2025.04.04.07.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 07:17:17 -0700 (PDT)
Date: Fri, 4 Apr 2025 11:17:13 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [REGRESSION] Kernel reboots unexpectdely on i.MX8X when Cortex-M4 is
 running and it was started by U-Boot bootaux
Message-ID: <20250404141713.ac2ntcsjsf7epdfa@hiago-nb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

#regzbot introduced: 4f6c983261

Hi Peng and all,

Commit 4f6c9832613b ("genpd: imx: scu-pd: initialize is_off according to
HW state") introduced a regression where the Kernel reboots unexpectedly
(without any warnings, crashes or errors) when the Cortex-M4 was loaded
and running by U-Boot, using the bootaux command:

# load mmc 0:2 ${loadaddr} /home/root/hello_world.bin
# bootaux ${loadaddr} 0
# boot

This is a simple hello world binary that prints a message into the
M40.UART0 pin (demo from NXP MCUXpresso).

Before this commit, everything worked as expected, Linux boots fine and
the HMP core keeps running and printing messages to the UART. After the
commit, the kernel reboots at the beggining of the boot process. The
only relevant message is printed by U-Boot after reset:

"Reset cause: SCFW fault reset"

This commit was bisectabled, the same device tree, u-boot version, and
SCFW versions were used. Reverting this commit fixes the issues.

For testing purposes, I created the following patch which also fixes the
issue:

diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
index 38f3cdd21042..0477b3fb4991 100644
--- a/drivers/pmdomain/imx/scu-pd.c
+++ b/drivers/pmdomain/imx/scu-pd.c
@@ -539,6 +539,9 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
                return NULL;
        }

+       if (strstr("cm40", sc_pd->name) != NULL)
+               is_off = true;
+
        ret = pm_genpd_init(&sc_pd->pd, NULL, is_off);
        if (ret) {
                dev_warn(dev, "failed to init pd %s rsrc id %d",


Test Environment:
- Hardware: Colibri iMX8DX 1GB with Colbiri Evaluation Board.
- U-Boot Version: 2024.04
- U-Boot Build info:
	SCFW 83624b99, SECO-FW c9de51c0, IMX-MKIMAGE 4622115c, ATF 7c64d4e

The issue is not present on: v6.5

The real root cause is still unclear to me. Anybody has any ideas? I am
happy to share more details if needed.

Cheers,
Hiago.

