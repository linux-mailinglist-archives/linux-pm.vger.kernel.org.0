Return-Path: <linux-pm+bounces-25830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2916A95FD1
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 09:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D88F1896BBE
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 07:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F074F1E2848;
	Tue, 22 Apr 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CR8KgOZU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF601CAA79
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308068; cv=none; b=rFtHiookNEfPeFxe+N+uSCWhbzf64y9A096sEfcG125JTe0jsQocW+CHKeoGx0j0ozmRyiUBdxXxmwwj8TzX5I6bMgKb8UpLA0LnHGsdKmc9cWBgOSsWx/z80dgcoeBPiSvvy4yJQYfUeBwz+9pQbrfcv5z0N+AotzhRsKR9nTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308068; c=relaxed/simple;
	bh=gYBCtmcJwyBrgGgeZj1AG+YLAnJPuvkOb/Fa/7ENihU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=abva08bdtAL4nAaXsTDDQxzshJv5oG/g1mwxT5vvRpA0feRvLwjnB115DthmC+7x4R5A6yVlV54QN13zZsIc9Z2rVdO6jsG70vFrve4T65ii9/JtbCEfpUwjLzHnXvyrOp7AKuyPuuFFJcIyMpD7WBq4REu1w/e+QWIgAEgvCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CR8KgOZU; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250422074737euoutp01ddb359dff1d73ad910dfb01dc3d043d3~4lG5xUjeL1216312163euoutp01Q
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 07:47:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250422074737euoutp01ddb359dff1d73ad910dfb01dc3d043d3~4lG5xUjeL1216312163euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745308057;
	bh=YhGFLkEzKgz+GfyN4OdYyuMG4I+CyiVDnG8UcSjurlI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=CR8KgOZUrftR9/Eqo4u0/5IySoaChZq+JpkQg/Y5g60SlY35JuhD4tImWkpqj6N8f
	 sdTxik2CqHBYBNHgAORBVan/z23C051OkWAlXzl2DM273g6WgEVfxTAB93Sk/AF14T
	 t+Mqc2JfBTC27GyPmmbxcDSI3qW8lq4cAgmk2lRA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250422074736eucas1p26785e0aa606a0551d57b635f9f7cb724~4lG5EMJ6s0798107981eucas1p2P;
	Tue, 22 Apr 2025 07:47:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 57.65.06072.89947086; Tue, 22
	Apr 2025 08:47:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250422074736eucas1p229d8a46d24bc2b62fba4835f225d34cc~4lG4cllm00585305853eucas1p2Z;
	Tue, 22 Apr 2025 07:47:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250422074736eusmtrp25d4f37e4a76d45889912395ff4e4d1f6~4lG4brYS01493814938eusmtrp2h;
	Tue, 22 Apr 2025 07:47:36 +0000 (GMT)
X-AuditID: cbfec7f5-7f7fe700000017b8-f9-680749984146
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 3D.78.19920.89947086; Tue, 22
	Apr 2025 08:47:36 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250422074734eusmtip23ed507b3f619e62e76af9e5cdabc81a4~4lG3Mfp3_1123511235eusmtip20;
	Tue, 22 Apr 2025 07:47:34 +0000 (GMT)
Message-ID: <81e53e3a-5873-44c7-9070-5596021daa42@samsung.com>
Date: Tue, 22 Apr 2025 09:47:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/21] riscv: dts: thead: Introduce reset controller
 node
To: Drew Fustini <drew@pdp7.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, frank.binns@imgtec.com, matt.coster@imgtec.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
	airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org,
	jszhang@kernel.org, p.zabel@pengutronix.de, m.szyprowski@samsung.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <aAP1BW3RmMb/Irya@x1>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTVxjHc25v773tLF4KhCOTuBRfoslA3D6cAXO66LxsixFiWELcsBnX
	4sZrC3MsQ0FeBKnAxAUpTLAQ6IroJgUpo4NUUoqMOwcIRGkhE5fBBCyIhBfpKBc3vv2e//M/
	z1sOJZCaCB/qdHwyq4yXx8oIMd5kWeDevBpKxux9NroHWQe1GGpc0pDohonDUEUHJ0T2XgOG
	+uemCXTzyX0S/W3KwNGA7gcSZVpuEWhcYyeQQ20Xor6WcgLNXuoAqGk2i0D1HTYSXXc04qi6
	uQWgnLwaIfrj3mFks1txNN6nFqAczWbkbG0m0crAzzgqm2ojkeHpd0LUWf8Jymq7gh/wZaaH
	sknm6fg4ztzNfU4ypheVOGPU2EhGbfwNMLf1eQQzPNBKMNe6wpiR/E6Maag+x2TVWzCm8OVe
	ZvrXBwRTYNADpjdzkDwmjRSHRLOxp79ilQH7T4pjfhzIJRO76a8n8yLTQavkIhBRkH4bnrdk
	EheBmJLSOgC5SquAD54DmGvWknwwC+Cyfkrw6kn65Zl1Vy2AZueNddckgDnL5WsuCb0fFuX3
	Ahfj9A74uKpjXXeHXaVjuIu96G1w5OFV0sUedDh85PxlTfek34CcrhdzFRXQdULY0T6LuRIC
	2hs+HKtYY4LeB0drK4QuFtEyWDs0D3jPNnhnsnxtPEh3iWG2th/wcx+CdVnFQp494ESngeR5
	K3Qa+aKQToCjjTPre34LjerOdQ6Gw9zi6pmo1Qa74a2WAF4+CH+vLgMuGdJucGjSnR/BDV5u
	KhHwsgTm5kh59074vfrSf005XRNWBGSaDVfRbFhSs2EZzf99KwGuB95siipOwareimfP+Kvk
	caqUeIX/5wlxt8HqD+9e6ZxrBroJh78ZYBQwA0gJZJ6SxQ/IGKkkWp76DatMiFKmxLIqM3id
	wmXeEm1btkJKK+TJ7Jcsm8gqX2UxSuSTjqUXPLYc/zN08/zHh5MWj2CiuffCSs+x6hoYdX3H
	iLJq+mZttDWYUqT5v2MOXzGKPJoKkxzWGT9lj5u76cLUrrRGR0g6WTfRnursfm1h+wlb0O6z
	RZ9tOmgq5E5FcTa0FPrP1EK7Ma0q+eX9XXORx4NNJ3XzDaKjrDRDlPHXdrzoTNHZxIiawaEt
	+e/7Ej2c3yOzJdJKBx5xnrqrfTLeUNcTmPJpyYOgyX6rZt6yEhSxLzXsxJZi8c5qqyAu5MWU
	b/By65WAytDw2jx1WJKnhwIRY5vchxv77F4lX7xbeuFDr6VrW4/95DcfoT90/kC04SOfO719
	xUZ5exn7rOBeWPhRGa6KkQfuEShV8n8BLph1sFAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsVy+t/xe7ozPNkzDH6d5LQ4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xcKPW1ksluzYxWjR1rmM1eLiKVeLu/dOsFi8vNzDbNE2
	i9/i/54d7Bb/rm1ksZj9bj+7xZY3E1ktjq8Nt2jZP4XFQdbj/Y1Wdo83L1+yeBzu+MLusffb
	AhaPnbPusnv07DzD6LFpVSebx51re9g85p0M9LjffZzJY/OSeo+WtceYPPr/Gni833eVzaNv
	yypGj0vN19kDhKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
	Uov07RL0MlZe62AvOC1Q8bYzqoFxD28XIyeHhICJRMOkT8xdjFwcQgJLGSXOz21mhEjISFzr
	fskCYQtL/LnWxQZR9JpR4mzPdrAiXgE7iQndl8BsFgFViceLjzBDxAUlTs58AtYsKiAvcf/W
	DHYQW1ggSOL2/91gcREBBYlzKy4xgQxlFljNKrH8611GiA0PGCU+73vAClLFLCAucevJfCYQ
	m03ASOLB8vlgcU4BJYnlN74DNXAA1ahLrJ8nBFEuL7H97RzmCYxCs5DcMQvJpFkIHbOQdCxg
	ZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRmLK2Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuH9
	5caeIcSbklhZlVqUH19UmpNafIjRFBgWE5mlRJPzgUkzryTe0MzA1NDEzNLA1NLMWEmc1+3y
	+TQhgfTEktTs1NSC1CKYPiYOTqkGpsyl17LvrjOo49vy7/j3PQ/+JHi9XtFQLyr2wdr9adcq
	xgNPf8w+7bH0EsvSidofU4MXXPJJNrnusYlJrzFdW8rwtWcmW5nRj7W+LuzKiRuvZ0j0He9X
	nnxxV+qr8C1nz6eskTpV+KXj5pVXzK9v/JX98C0sUXlReamww0krn/yKcvftCxQl/16Wf/Mg
	Ty/AqZzx+c8mjjSvw13NnTqT3gkvbDV2Xcl97zxL0D5nhVTNf7Y5yz44/WfecKv7REXesjlJ
	y+f9/8ttwsZw+Mwddo/XThOTHzpfYL3Aka7SoaK241xZpe7efbdOtjDFZDkYl+m8P+NcuzpK
	Trft/Kzrxy02tdqk5nsnbxY1eNHjpsRSnJFoqMVcVJwIAGzRxpviAwAA
X-CMS-MailID: 20250422074736eucas1p229d8a46d24bc2b62fba4835f225d34cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250219140316eucas1p29a76023868946f090f261bf78d5103e3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250219140316eucas1p29a76023868946f090f261bf78d5103e3
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
	<CGME20250219140316eucas1p29a76023868946f090f261bf78d5103e3@eucas1p2.samsung.com>
	<20250219140239.1378758-21-m.wilczynski@samsung.com> <aAP1BW3RmMb/Irya@x1>



On 4/19/25 21:09, Drew Fustini wrote:
> On Wed, Feb 19, 2025 at 03:02:38PM +0100, Michal Wilczynski wrote:
>> T-HEAD TH1520 SoC requires to put the GPU out of the reset state as part
>> of the power-up sequence.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  arch/riscv/boot/dts/thead/th1520.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
>> index 474f31576a1b..6b34aab4b455 100644
>> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
>> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
>> @@ -7,6 +7,7 @@
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/clock/thead,th1520-clk-ap.h>
>>  #include <dt-bindings/power/thead,th1520-power.h>
>> +#include <dt-bindings/reset/thead,th1520-reset.h>
> 
> Are you okay if I omit this hunk? My thead-dt-for-next branch is based
> on 6.15-rc1 but thead,th1520-reset.h only exists in next until the merge
> window.

Yeah, I'm not exactly sure how to coordinate such stuff, obviosuly it
would be best if this chunk would make it to the 6.16, but if you think
it would be problematic then omit it, no problem.

I will then update this patch series v3 [1] to gracefully handle lack of
reset, as the 6.16 will not contain the required reset line for sure.

[1] - https://lore.kernel.org/all/20250414-apr_14_for_sending-v2-2-70c5af2af96c@samsung.com/

> 
>>  
>>  / {
>>  	compatible = "thead,th1520";
>> @@ -497,6 +498,12 @@ clk: clock-controller@ffef010000 {
>>  			#clock-cells = <1>;
>>  		};
>>  
>> +		rst: reset-controller@ffef528000 {
>> +			compatible = "thead,th1520-reset";
>> +			reg = <0xff 0xef528000 0x0 0x4f>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>>  		clk_vo: clock-controller@ffef528050 {
>>  			compatible = "thead,th1520-clk-vo";
>>  			reg = <0xff 0xef528050 0x0 0xfb0>;
>> -- 
>> 2.34.1
>>
> 
> With the above caveat:
> 
> Reviewed-by: Drew Fustini <drew@pdp7.com>
> 
> 
> -Drew
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

