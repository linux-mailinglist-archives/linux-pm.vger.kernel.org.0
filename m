Return-Path: <linux-pm+bounces-2141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F15582BB32
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 07:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A519A1F267FC
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 06:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EFE5C8E5;
	Fri, 12 Jan 2024 06:18:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412FF5C8E1;
	Fri, 12 Jan 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Received: from [192.168.0.174] ([62.226.33.204]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MBDvU-1rJFz42POA-00Cmkv; Fri, 12 Jan 2024 07:18:24 +0100
Message-ID: <8ab0800d-e553-408c-88d7-6ae8b7798a87@oldschoolsolutions.biz>
Date: Fri, 12 Jan 2024 07:18:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: qcom: tsens: remove dependency to
 NVMEM_QCOM_QFPROM
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
To: Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 konradybcio@kernel.org
References: <39e0f711-9331-4fd2-9d78-be53afb5c37d@oldschoolsolutions.biz>
Content-Language: en-US
In-Reply-To: <39e0f711-9331-4fd2-9d78-be53afb5c37d@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OqoK9sYBdc9YX1A2eTJrsaugkhswEzl6pctUQyXiyW5/QWlBzUu
 ELflV7nWd67Q/PoUxcdfxy1L4aYUy5pWQ0h1SYjs5zus5k2VnXd8o7LKIyDOtiK60cp6EGS
 ey1lASoIqRWjDvdzS4KQ0LmOQUfdodFzCjFtBSAsnJEXZQSRJ+EOBd0y1j8pMG6R/hvEZ23
 vlU6rJHoMPdf6VWrKt/gg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qrx4Nvf7nj4=;9ayq4msTfDJq3PuJl3RrX7S4s+0
 q7uQH59NVCDMSJ71z87PoHGxa6ZyJdOrejCK/VwXrM+QdnGAko82hYEo++on0QP9HrgnoG7om
 Lx7AdL7I6TO1EP1iHswDqHrCo82OSm2/+WKRHLUgQRKapxzbNuj41CS7DXomOwq1DvyrfzQ8f
 HepuUacGi3KF/lb8gv5Ru9Xc7W3bTlgougyh2ibBelNHt17Vwkw8wOkhJANMKsxGAZh6hSW8s
 zK1C8+G50ReEv1ri3vvDIuCbC584yRu4QcYkYOmiwxLWFtcbr7jFjAjMi2U9qkHdlJg3smS0Y
 aYPBm/tVMJLogw/X3MNO3tlKi3WuRn3YkLJKCU3mwWy2SEPzkpCGJ8GKbtaLpa/4i1qu/MM3C
 CQo4/M+Jy1vMRhl+DmZywOhbDXwRLSkTcb5DbEcvKXWPXAplASG5S7+Y/+9w4OVHG72LGyJ+C
 NOLcU7eIbn87p+hwFZeCjulH1otSY9dT27M2ASQaO8+fhwCTKgoskZ8jyNbl0TOUlrrPc6uf/
 WK2R2Vuiawv7/uNmOh1EqYLQSFtFTVoAKDhDAG6Ci0/UnveON8e5YqDhAVanZSl1HcM5LVBsw
 cIAp2QjR1GJFinMs5YoFUoowQ8vstJTnQP+Vme+wENMlrdL6NoUcLaHplYOQZCO/aoq1/t6+d
 BjUIjbhyho4UrjVdvFzw+M0G8AmoG9Jz/fSZ4zIQITZBFrL2MYPyRqAIuEBoWsJWsQaA7qOeC
 QPq9wG8wCNHZHHpg/T74FZzg0MDRVIRyp7H9r6ySBEHNtKarec7xBqitrzktxNJVguIKn+Lm8
 Wx5z3IYo0IqiIsObJ+QJvEE+kNuNo+HG9ubqSIfsLx+zI511lSxcANcRLZFtVNffR20gtxHUS
 +TUFZ7d18BrSgQQ==

Hi there,

please don't bother with this patch. Re-checked and works as intended if 
done in the right order.

with best regards

Jens

On 12/20/23 23:05, Jens Glathe wrote:
> The dependency to NVMEM_QCOM_QFPROM seems to be a problem when using
> "make menuconfig", it will exclude QCOM_TSENS from the build wWith
> bad effects on power management, observed on the Windows Dev Kit 2023,
> and Thinkpad X13s. Removing it doesn't have a negative side effect,
> as it seems. Observed this since v6.6.
>
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
>  drivers/thermal/qcom/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index c4ebb1977b177..09d9b35c57bd2 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config QCOM_TSENS
>      tristate "Qualcomm TSENS Temperature Alarm"
> -    depends on NVMEM_QCOM_QFPROM
>      depends on ARCH_QCOM || COMPILE_TEST
>      help
>        This enables the thermal sysfs driver for the TSENS device. It 
> shows

