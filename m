Return-Path: <linux-pm+bounces-23468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B55A4F864
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 09:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D4416F598
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2081F4E3B;
	Wed,  5 Mar 2025 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AVpjaFAG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B81EE03D
	for <linux-pm@vger.kernel.org>; Wed,  5 Mar 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741161855; cv=none; b=dmP6wOOVC17Y/ROeNnSHEvPqpmsL06fsZz8HZogZf+sxZaES9j45lz99fIbBxYtBr3EwUPcGQISn8mcwt3gJrk9QoFXQ+1sxXXPQBKduuiqlfHbMOi++syJ/FGYQWAP+y5FaKrxOK9Ft571ka22YNyNWAZmeQiWE3YN1yEff/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741161855; c=relaxed/simple;
	bh=XxShrfII1iW48sEm+1idv7RpgL37yrsUd3ZA5lWJqmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=EfZjLTs0knhzpYsuiTgNy7dUtd9JRGhl3JuLii+L6qI/zEytqKA1fuTjQwY5rwgsxEuzPO8g/4EDXCWbzMwLPNgYE1XZQuI+AC6V8u8t8OFQ7AZmm5T1/EGzBJCfnSFyG2kLt/AVzm03A5M4xcGB5ub/c3MYISPxX5tdlTBSswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AVpjaFAG; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250305080405euoutp02d0e9845d5ed3ba829d742a0ad7d21355~p2XlGrxUf2097420974euoutp02e
	for <linux-pm@vger.kernel.org>; Wed,  5 Mar 2025 08:04:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250305080405euoutp02d0e9845d5ed3ba829d742a0ad7d21355~p2XlGrxUf2097420974euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741161845;
	bh=GnXY0ytHs9JstH2dWkqOUDOxCaeFg6+8UfoPoS8CNm0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=AVpjaFAGCy7hNPB+HGj8BG9cN9i7qCURzC3pzitan2DFXB5OU087zs7nF7hCKde7p
	 RfAodIFCh5akwzQ/6w0ON7SkKwNRjNQSEAzNxVW2oL/4lAloG8toqrHLVKIZI2g8ib
	 2MHRe6Sk8fjGvJKdEcHg86Nr3pcdKomQqgBhuUig=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250305080405eucas1p269322ff4dff3a7efa7c0217d2d760140~p2Xkksspc1362113621eucas1p2W;
	Wed,  5 Mar 2025 08:04:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id F3.C1.20409.57508C76; Wed,  5
	Mar 2025 08:04:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250305080404eucas1p2cff5ea6161b7c6a71cd0ff81aedad061~p2Xj_wj4L1362113621eucas1p2U;
	Wed,  5 Mar 2025 08:04:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250305080404eusmtrp188a9d70d20b5fa05c891eba7157342f5~p2Xj99l6u3067730677eusmtrp1q;
	Wed,  5 Mar 2025 08:04:04 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-04-67c80575adf4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 7A.09.19654.47508C76; Wed,  5
	Mar 2025 08:04:04 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250305080403eusmtip2e81659e53d59c3b079c327a133bb3e6d~p2XjImQTE2244322443eusmtip2H;
	Wed,  5 Mar 2025 08:04:03 +0000 (GMT)
Message-ID: <8f04da41-c868-4ab2-83bc-c06a8f182e81@samsung.com>
Date: Wed, 5 Mar 2025 09:04:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] TH1520 SoC: Add AON firmware & power-domain
 support
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20250303145901.446791-1-m.wilczynski@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7djPc7qlrCfSDf4/4LF4ducrq8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFm82NvIYtF8bD2bxctZ99gsLu+aw2bxufcIo8W2zy1sFmuP3GW3
	eHm5h9mibRa/xf89O9gtjq8Nt2jZP4XFQdDjzcuXLB6HO76we9w7MY3VY9OqTjaPO9f2sHls
	XlLv0bL2GJPH+31X2Tz6tqxi9LjUfJ3d4/MmuQDuKC6blNSczLLUIn27BK6MzfeXsBSclar4
	+G01UwPjXZEuRk4OCQETiTm3DzB2MXJxCAmsYJRY8/8tlPOFUeLQyh/MEM5nRon9O9cAORxg
	LRsuOYN0CwksZ5RYMFkWouYto8Sim9MZQRK8AnYSP279BLNZBFQkNpz7xQ4RF5Q4OfMJC4gt
	KiAvcf/WDLC4sECgxINnEMtEBPqZJPqO/GcFSTALVEqsuHCUDcIWl7j1ZD4TiM0mYCTxYPl8
	VpCDOAXsJT41aEKUyEtsfzsHbI6EwDVOiZ77Z1kh/nSROHhuApQtLPHq+BZ2CFtG4vTkHhYI
	O1/iwdZPzBB2jcTOnuNQtrXEnXO/2EB2MQtoSqzfpQ8RdpRYdO0FKyRM+CRuvBWEOIFPYtK2
	6dCg4pXoaBOCqFaTmNrTC7f03IptTBMYlWYhBcosJD/OQvLMLIS9CxhZVjGKp5YW56anFhvl
	pZbrFSfmFpfmpesl5+duYgQmxtP/jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeF+fOp4uxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnHfR/tZ0IYH0xJLU7NTUgtQimCwTB6dUA5PDAo9v4m59Ci0sE2P0
	J4Ro6/yfvsZpeYzRlacn1E+Lh3jfOt5h0SJRLb/2D8MtS8mjm79xVPMITdrwvZRBgfHfotOr
	E5ayO13X7P0dvHT7RVGv720z1h2UWK5QV2nsU7vX+r+aVbfQ3STHKuGeNa9Mry4x5Lc/qni0
	+AL3wZjJiaczLEsfKzKL3lPbrvRrRs5sl32Ojls3bDK4lHz8n7s974KAq8Hl7Y+N3DR8z4bn
	cRt7ce1te/zJzz6/J9DK5fk33XuTX5U0PHytsCzIvuu4e+ptE6bXnzcU3Gu9pVerMb/kSjXT
	So0DM3crh543tdV4wTfn4K4NyrLatmcCdMsKJvoqCXBwz3a8fc1OXImlOCPRUIu5qDgRAO0/
	wbr7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsVy+t/xe7olrCfSDU58VLJ4ducrq8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFm82NvIYtF8bD2bxctZ99gsLu+aw2bxufcIo8W2zy1sFmuP3GW3
	eHm5h9mibRa/xf89O9gtjq8Nt2jZP4XFQdDjzcuXLB6HO76we9w7MY3VY9OqTjaPO9f2sHls
	XlLv0bL2GJPH+31X2Tz6tqxi9LjUfJ3d4/MmuQDuKD2bovzSklSFjPziElulaEMLIz1DSws9
	IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MzfeXsBSclar4+G01UwPjXZEuRg4OCQETiQ2X
	nLsYuTiEBJYySvzc+Zyxi5ETKC4jca37JQuELSzx51oXG4gtJPCaUaJjuziIzStgJ/Hj1k+w
	ehYBFYkN536xQ8QFJU7OfALWKyogL3H/1gywuLBAoMSDZz+YQZaJCPQzSTw/sh6smVmgUuLx
	k9usEFdMYpT4vfoGM0RCXOLWk/lMIDabgJHEg+XzWUGu5hSwl/jUoAliMguoS6yfJwRRLS+x
	/e0c5gmMQrOQnDELyaBZCB2zkHQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJEZgIth37
	uWUH48pXH/UOMTJxMB5ilOBgVhLhfX3qeLoQb0piZVVqUX58UWlOavEhRlNgUExklhJNzgem
	orySeEMzA1NDEzNLA1NLM2MlcV62K+fThATSE0tSs1NTC1KLYPqYODilGpimi506cU2gJcFp
	Em/dhG7G2ojeGsHnWSppJ3fuXLVPZnXsfgXVnWmP9h73/XcwiXP9vaYrGmEiVWZyDttvOitt
	45/YPPO0tGn+mYjXz26qbXoyuzLq8077FzfOPwmuWnpGn6203eVhYNeLiS8d13hF/a88b7zw
	u07A99tPzj2R5Z+Ur2jgz1m1N/HvIt6tHl4T11lNsVXiWRex+77My0uzDnc6vzUInSTPseDH
	zYcmgvxmyY83vW/7xBetJ73P91ZCweFld3XvTft33fS8vVGRzqp4jXXzVJLrthu9D/kU80aa
	J6tjwSEu/QN7wm9l/7/oHni5csIst9k8e3arVl2cEHHK+ruExrPIOe5Z0/U9lFiKMxINtZiL
	ihMBc1pqnI0DAAA=
X-CMS-MailID: 20250305080404eucas1p2cff5ea6161b7c6a71cd0ff81aedad061
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303145917eucas1p171f8fcccadddc035f5773f7026a281e3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303145917eucas1p171f8fcccadddc035f5773f7026a281e3
References: <CGME20250303145917eucas1p171f8fcccadddc035f5773f7026a281e3@eucas1p1.samsung.com>
	<20250303145901.446791-1-m.wilczynski@samsung.com>



On 3/3/25 15:58, Michal Wilczynski wrote:
> This patch series introduces and documents power management (PM) support and
> the AON firmware driver for the T-Head TH1520 SoC, as used on the LicheePi 4A
> board. While part of a larger effort to enable the Imagination BXM-4-64 GPU
> upstream, these patches can merge independently.
> 
> Bigger series cover letter:
> https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/

This series should be versioned as v6, to maintain continuity with the
bigger patchset it is a subseries of. Please find below a changelog for
the AON & power-domain:

v6:
- split the firmware & power-domain patches into a separate series

v5:
- changed the AON driver to be a set of library functions rather than a
  standalone driver

v4:
- added workaround to disable AUDIO power domain to prevent firmware crashes

v3:
 - consolidated device tree representation by merging aon and power-domain nodes
   while maintaining separate drivers internally
 - power-domain driver is now instantiated from within the aon driver
 - fixed optional module dependencies in Kconfig
 - added kernel-doc comments for all exported functions
 - implemented th1520_aon_remove() to properly clean up mailbox channel
   resources

v2:
 - introduced a new firmware driver to manage power-related operations.
 - rewrote the power-domain driver to function alongside the firmware driver.
   These nodes in the device tree lack direct address spaces, despite
   representing HW blocks. Control is achieved via firmware protocol messages
   transmitted through a mailbox to the E902 core.
 - added new dt-bindings for power and firmware nodes.
 - ran dtbs_check and dt_binding_check to ensure compliance.

> 
> Michal Wilczynski (5):
>   dt-bindings: firmware: thead,th1520: Add support for firmware node
>   firmware: thead: Add AON firmware protocol driver
>   dt-bindings: power: Add TH1520 SoC power domains
>   pmdomain: thead: Add power-domain driver for TH1520
>   riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs
> 
>  .../bindings/firmware/thead,th1520-aon.yaml   |  53 ++++
>  MAINTAINERS                                   |   5 +
>  arch/riscv/Kconfig.socs                       |   1 +
>  drivers/firmware/Kconfig                      |   9 +
>  drivers/firmware/Makefile                     |   1 +
>  drivers/firmware/thead,th1520-aon.c           | 247 ++++++++++++++++++
>  drivers/pmdomain/Kconfig                      |   1 +
>  drivers/pmdomain/Makefile                     |   1 +
>  drivers/pmdomain/thead/Kconfig                |  12 +
>  drivers/pmdomain/thead/Makefile               |   2 +
>  drivers/pmdomain/thead/th1520-pm-domains.c    | 209 +++++++++++++++
>  .../dt-bindings/power/thead,th1520-power.h    |  19 ++
>  .../linux/firmware/thead/thead,th1520-aon.h   | 200 ++++++++++++++
>  13 files changed, 760 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>  create mode 100644 drivers/firmware/thead,th1520-aon.c
>  create mode 100644 drivers/pmdomain/thead/Kconfig
>  create mode 100644 drivers/pmdomain/thead/Makefile
>  create mode 100644 drivers/pmdomain/thead/th1520-pm-domains.c
>  create mode 100644 include/dt-bindings/power/thead,th1520-power.h
>  create mode 100644 include/linux/firmware/thead/thead,th1520-aon.h
> 

