Return-Path: <linux-pm+bounces-23921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD416A5DEFC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 15:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0ED3B2E46
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 14:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E9F23E345;
	Wed, 12 Mar 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="asrTPuoj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6356D73451
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789876; cv=none; b=FsyraRJFy8NF086PIw64lQclLCjCQ395Fj64v0CvWI0P+ERcKPSh4OH9waknJMYLeaGiFwpn7EFYRxAfa+1hWJlSv+63Ws/3Q3vW6GofO1/8R4PqxnTf54k3SB35sm5+CTsA3WSbz516CHGPVYx1Zvysch7LMKVdjGoVdEd9hrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789876; c=relaxed/simple;
	bh=gaLQEB0SodFsAMFUf7U0XOJDsFQAXxh4Qwrquyn+gOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=befmZBQkL9H1N/Zz2U3T+EM0JJjBwN44PeonVeHH6g41fWXT6Q8GT1lQ+SopzcxJsZmHJ2m4dGlFH7V3MRVddVcC3EMfXuWOOjVCMRl+H9lMc88HozmzdNm9lRkOcwl1pUTMnxEBXlXeRRj6ZJc0chGE7l07QYflC6feVtd7fE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=asrTPuoj; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250312143106euoutp023c44c413f090e9938869bb87d46f0c83~sFKe1c-1Y0386803868euoutp02p
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 14:31:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250312143106euoutp023c44c413f090e9938869bb87d46f0c83~sFKe1c-1Y0386803868euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741789866;
	bh=HnNcfwuXLGzsfvb6BDDyoiMjkg8CaNMTx1t8raBxs8w=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=asrTPuojlI5fCuvw5P8zGLgaOyB9y8r+a0SHRhZ+kdHTcswwOVwR9XoqC8a4U6ja6
	 JngZiqX/74HATy5urvzMhSUKgBmcZndewwGkrVyGTr0Na4aI/vm0/QYr0esK5tJ+jc
	 CaXbPwLo04tObtNjo7jLKz4L95gW8dgUOzmAhK4U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250312143106eucas1p10573c9cfc8a335a17c7693e49baae594~sFKedJ3_F2225522255eucas1p1I;
	Wed, 12 Mar 2025 14:31:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 36.05.20409.9AA91D76; Wed, 12
	Mar 2025 14:31:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250312143105eucas1p28e084a13846ec3a228745ffea6f12dbf~sFKd5EkDa2675626756eucas1p2Z;
	Wed, 12 Mar 2025 14:31:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250312143105eusmtrp1ca1951535f7ffd1b4ac1436b1cb77495~sFKd4UBcp2360523605eusmtrp1O;
	Wed, 12 Mar 2025 14:31:05 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-71-67d19aa9baec
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C6.2F.19920.9AA91D76; Wed, 12
	Mar 2025 14:31:05 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250312143104eusmtip2ee3c4f1dba47a901cfe23aae17ecfa4a~sFKdERw6m2544525445eusmtip2i;
	Wed, 12 Mar 2025 14:31:04 +0000 (GMT)
Message-ID: <4b45236e-8252-4dd5-b3f7-3595b0924182@samsung.com>
Date: Wed, 12 Mar 2025 15:31:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] TH1520 SoC: Add AON firmware & power-domain
 support
To: Ulf Hansson <ulf.hansson@linaro.org>, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, jszhang@kernel.org, m.szyprowski@samsung.com,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CAPDyKFqeaq5xVNA=0CpMWSt_78qXJsY6+mpE1CSmLrVMQazAjg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7djP87orZ11MN7h00tTi2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	4uXlHmaLtln8Fv/37GC3OL423KJl/xQWB0GPNy9fsngc7vjC7nHvxDRWj02rOtk87lzbw+ax
	eUm9R8vaY0we7/ddZfPo27KK0eNS83V2j8+b5AK4o7hsUlJzMstSi/TtErgyWiYcYC3YrlJx
	sfMGawPjCZkuRk4OCQETibV9Cxi7GLk4hARWMEr8v/mbCcL5wijROnk7lPOZUeLh+l2MMC39
	zf/YIRLLGSXO/r7NDOG8ZZSY8beDCaSKV8BOYsq3XawgNouAqsTr/U/ZIOKCEidnPmEBsUUF
	5CXu35rBDmILCwRKbJ+5B2yDiECsxMwJs8FWMwvsZpJ42nUUrIhZQFzi1pP5YAvYBIwkHiyf
	D7SAg4MTqPn0q2SIEnmJ7W/ngB0kIXCJU2JN02I2iLNdJLZee8kMYQtLvDq+hR3ClpE4PbmH
	BcLOl3iw9RNUTY3Ezp7jULa1xJ1zv9hAdjELaEqs36UPEXaUeHi5gQkkLCHAJ3HjrSDECXwS
	k7ZNZ4YI80p0tAlBVKtJTO3phVt6bsU2pgmMSrOQAmUWkh9nIXlmFsLeBYwsqxjFU0uLc9NT
	i43yUsv1ihNzi0vz0vWS83M3MQKT4+l/x7/sYFz+6qPeIUYmDsZDjBIczEoivKttL6QL8aYk
	VlalFuXHF5XmpBYfYpTmYFES5120vzVdSCA9sSQ1OzW1ILUIJsvEwSnVwDTN/Ui1Qazkh/MX
	+r41T+J8eabff7uVSMGSrODeW3elg36wcp1RYtWNuOOiP1spu/VXwi0jp2Aj1btMck+zdlz+
	lCQ3R6dgdoX+MY6pbLGbf0WLbPj/7uVFRvvbtS9+ft+zsOSEv8qSPyIf/MMuZIXt8b0n8CTF
	nulg4bx9zvFnlv38d89aa/OKpHsOgWkl0f4TrKbpVG4K+D/LafmC/yFiF68wnrr3qVPzplJz
	+UqxzuPVr999l+5Y0lxlyuL4Zd8qD84pf08m6yssex5lefurZeyZOw8fnY1jkOncpnO56fDT
	N+GMK5a22jAvtnHsZT6cuEBx2Z0i94sblzxNlDum0dGT3ikxZWr48+2SJ7iUWIozEg21mIuK
	EwGJLdmU/QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xe7orZ11MN9jzUNji2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	4uXlHmaLtln8Fv/37GC3OL423KJl/xQWB0GPNy9fsngc7vjC7nHvxDRWj02rOtk87lzbw+ax
	eUm9R8vaY0we7/ddZfPo27KK0eNS83V2j8+b5AK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30
	jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyWiYcYC3YrlJxsfMGawPjCZkuRk4OCQETif7m
	f+xdjFwcQgJLGSVufD3CBJGQkbjW/ZIFwhaW+HOtiw2i6DWjxJ+G5YwgCV4BO4kp33axgtgs
	AqoSr/c/ZYOIC0qcnPkErFlUQF7i/q0Z7CC2sECgxPaZe8B6RQRiJT50bmEEGcossJtJ4szm
	P4wQG24xSpxc1AN2BrOAuMStJ/PBbDYBI4kHy+cDbePg4ASadPpVMojJLKAusX6eEES1vMT2
	t3OYJzAKzUJyxiwkg2YhdMxC0rGAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYDLYduzn
	5h2M81591DvEyMTBeIhRgoNZSYR3te2FdCHelMTKqtSi/Pii0pzU4kOMpsCgmMgsJZqcD0xH
	eSXxhmYGpoYmZpYGppZmxkrivG6Xz6cJCaQnlqRmp6YWpBbB9DFxcEo1MDleYitUrsh0m9qZ
	3PY7wcfUJ8Ht97Yjuk7HJqRuuGWqtX3qptN/2J64RGsFyE747fRS77ZyrbXruYk1tQy5X28G
	HJBWOment055o0O8/Rmxtxs3Vh2fKCBR2ZV1wLvH/Nb1gFe5/a4prRer1l/eHTBh97kC1p5N
	rfMac7X9121ffTm94Ls139GjlcscLHfL3dnG8PrT1SmfxbbV+p/kWf5o80PeST53w643712j
	tP3AxYfbuX7WmantcHTbr1Y3OaT78cGteYm9Oj4/tT294pO1RN65nz2qtVlm+97cfqZXxv67
	+zPbEnT2Ln+34VbAHdHyZSHqG7a8NGHOTq9xytI9fYLbIbX/9fSTdqz3NJRYijMSDbWYi4oT
	AW71z36PAwAA
X-CMS-MailID: 20250312143105eucas1p28e084a13846ec3a228745ffea6f12dbf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd
References: <CGME20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd@eucas1p1.samsung.com>
	<20250311171900.1549916-1-m.wilczynski@samsung.com>
	<CAPDyKFqeaq5xVNA=0CpMWSt_78qXJsY6+mpE1CSmLrVMQazAjg@mail.gmail.com>



On 3/12/25 14:40, Ulf Hansson wrote:
> On Tue, 11 Mar 2025 at 18:20, Michal Wilczynski
> <m.wilczynski@samsung.com> wrote:
>>
>> This patch series introduces and documents power management (PM) support and
>> the AON firmware driver for the T-Head TH1520 SoC, as used on the LicheePi 4A
>> board. While part of a larger effort to enable the Imagination BXM-4-64 GPU
>> upstream, these patches can merge independently.
>>
>> Bigger series cover letter:
>> https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/
>>
>> This series is versioned to maintain continuity with the bigger patchset it is
>> a subseries of. Please find below a changelog for the AON & power-domain:
> 
> I can pick up patch1 -> patch4 via my pmdomain tree, assuming I can
> get an ack from some of the thead-SoC maintainers.
> 
> Patch5 is probably better to be routed through the SoC maintainers
> tree, but let me know if you prefer me to take this one too.

Thanks, I don't have a preference, I'll leave it up to SoC maintainers.
I haven't included the device tree changes in this mini-series, as then
the PM & firmware, clock, and reset mini-series might conflict with each
other in th1520.dtsi file, but SoC maintainers might also find it useful
to pick this commit [1], along with the patch5.

[1] - https://lore.kernel.org/all/20250219140239.1378758-20-m.wilczynski@samsung.com/

> 
> Kind regards
> Uffe
> 
> 
>>
>> v8:
>> - add proper cleanup in the th1520_pd_probe()
>> - add "suppress_bind_attrs = true", since there is no need to unbound the driver
>>   during runtime. This simplifies the code by eliminating the remove function
>>
>> v7:
>> - add '#include <linux/slab.h", due to kernel robot issue
>>
>> v6:
>> - split the firmware & power-domain patches into a separate series
>>
>> v5:
>> - changed the AON driver to be a set of library functions rather than a
>>   standalone driver
>>
>> v4:
>> - added workaround to disable AUDIO power domain to prevent firmware crashes
>>
>> v3:
>>  - consolidated device tree representation by merging aon and power-domain nodes
>>    while maintaining separate drivers internally
>>  - power-domain driver is now instantiated from within the aon driver
>>  - fixed optional module dependencies in Kconfig
>>  - added kernel-doc comments for all exported functions
>>  - implemented th1520_aon_remove() to properly clean up mailbox channel
>>    resources
>>
>> v2:
>>  - introduced a new firmware driver to manage power-related operations.
>>  - rewrote the power-domain driver to function alongside the firmware driver.
>>    These nodes in the device tree lack direct address spaces, despite
>>    representing HW blocks. Control is achieved via firmware protocol messages
>>    transmitted through a mailbox to the E902 core.
>>  - added new dt-bindings for power and firmware nodes.
>>  - ran dtbs_check and dt_binding_check to ensure compliance.
>>
>> Michal Wilczynski (5):
>>   dt-bindings: firmware: thead,th1520: Add support for firmware node
>>   firmware: thead: Add AON firmware protocol driver
>>   dt-bindings: power: Add TH1520 SoC power domains
>>   pmdomain: thead: Add power-domain driver for TH1520
>>   riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs
>>
>>  .../bindings/firmware/thead,th1520-aon.yaml   |  53 ++++
>>  MAINTAINERS                                   |   5 +
>>  arch/riscv/Kconfig.socs                       |   1 +
>>  drivers/firmware/Kconfig                      |   9 +
>>  drivers/firmware/Makefile                     |   1 +
>>  drivers/firmware/thead,th1520-aon.c           | 248 ++++++++++++++++++
>>  drivers/pmdomain/Kconfig                      |   1 +
>>  drivers/pmdomain/Makefile                     |   1 +
>>  drivers/pmdomain/thead/Kconfig                |  12 +
>>  drivers/pmdomain/thead/Makefile               |   2 +
>>  drivers/pmdomain/thead/th1520-pm-domains.c    | 218 +++++++++++++++
>>  .../dt-bindings/power/thead,th1520-power.h    |  19 ++
>>  .../linux/firmware/thead/thead,th1520-aon.h   | 200 ++++++++++++++
>>  13 files changed, 770 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
>>  create mode 100644 drivers/firmware/thead,th1520-aon.c
>>  create mode 100644 drivers/pmdomain/thead/Kconfig
>>  create mode 100644 drivers/pmdomain/thead/Makefile
>>  create mode 100644 drivers/pmdomain/thead/th1520-pm-domains.c
>>  create mode 100644 include/dt-bindings/power/thead,th1520-power.h
>>  create mode 100644 include/linux/firmware/thead/thead,th1520-aon.h
>>
>> --
>> 2.34.1
>>
> 

