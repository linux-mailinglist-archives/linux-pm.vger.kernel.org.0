Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500B646539E
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 18:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351759AbhLARJQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 12:09:16 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56800 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351691AbhLARJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 12:09:12 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20211201170548euoutp01b067b93133f0690265bf577a2ac30770~8sG2K_iLA1735617356euoutp01j
        for <linux-pm@vger.kernel.org>; Wed,  1 Dec 2021 17:05:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20211201170548euoutp01b067b93133f0690265bf577a2ac30770~8sG2K_iLA1735617356euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1638378349;
        bh=n8Ec/z2dsswgLtQ4AikUPpC6nzdDjbStVPOaModBJrA=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=eJxmpW3xwThcDwdF/0QAiE1GiSbHefW/cQnjX7KgQBANzBe14LpXXPo4aVZKqMzoo
         OduQ3m5GLqwAKVVgRWER8/jmvq98XyYX5qq/tI4kWqVMZJq387b7U76valxfgKtHP3
         Oc7wRIYjMmLbCIqBlfDO4MOnJrpbs+NdNYuxmbRU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211201170548eucas1p24348ac2ebd4f68f96f5e4313d6f2e85e~8sG1_yLSg0862408624eucas1p2b;
        Wed,  1 Dec 2021 17:05:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2A.C3.09887.C6BA7A16; Wed,  1
        Dec 2021 17:05:48 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211201170548eucas1p2b71c76b3066ac378307e8428f9654882~8sG1qK-Kk3109631096eucas1p2n;
        Wed,  1 Dec 2021 17:05:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211201170548eusmtrp27831c11e7ea50c921c63969eb3b368ea~8sG1pdYAU1826118261eusmtrp2R;
        Wed,  1 Dec 2021 17:05:48 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-bd-61a7ab6c0309
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.3B.09522.C6BA7A16; Wed,  1
        Dec 2021 17:05:48 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211201170547eusmtip21608fe95cc694ccb4db637a6e91e8e0d~8sG1FoSpS1579215792eusmtip2U;
        Wed,  1 Dec 2021 17:05:47 +0000 (GMT)
Message-ID: <687ec764-78b4-4929-f9ec-373254d160a7@samsung.com>
Date:   Wed, 1 Dec 2021 18:05:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v3 1/4] cpuidle: qcom-spm: Check if any CPU is managed
 by SPM
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20211201130505.257379-2-stephan@gerhold.net>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7o5q5cnGpzcr21x7vFvFou/k46x
        W5ze/47FYt5nWYtNj6+xWkzcf5bd4nPvEUaLG3NNHDg8fv+axOjRtsDeY9OqTjaPO9f2sHls
        XlLv8XmTXABbFJdNSmpOZllqkb5dAlfGiiV8BX0SFfPW7mNuYDwi3MXIySEhYCJxefFe5i5G
        Lg4hgRWMEusPvWaEcL4wShyfsg3K+cwo8WbjC2aYltMXj0C1LGeUWPlyIitIQkjgI6PErsly
        IDavgJ3Eqy1b2UBsFgEViVMznzFBxAUlTs58wgJiiwokSUw4sRssLiwQLPHl5BSwOLOAuMSt
        J/PB4iICkRITls9nAVnGLHCJUeLahRZ2kASbgKFE19susAWcAlYSh/oPsUM0y0tsfzsH7DoJ
        gSccEhevbmCFONtF4un7K2wQtrDEq+Nb2CFsGYn/O0G2gTQ0M0o8PLeWHcLpYZS43DSDEaLK
        WuLOuV9A3RxAKzQl1u/Shwg7Siw9PZERJCwhwCdx460gxBF8EpO2TWeGCPNKdLQJQVSrScw6
        vg5u7cELl5gnMCrNQgqXWUj+n4XknVkIexcwsqxiFE8tLc5NTy02ykst1ytOzC0uzUvXS87P
        3cQITEin/x3/soNx+auPeocYmTgYDzFKcDArifDKz1yWKMSbklhZlVqUH19UmpNafIhRmoNF
        SZxX5E9DopBAemJJanZqakFqEUyWiYNTqoHJ7rh+VMXLVUxvL2/LkJjy9XOQFrfAIZUbHGlO
        N+1e7+cIsXz8/VPwgwXvg17fPMUdP/Udq7nSw61hInNfK+Zml6nuzOW4FfFhyt/LIk6Ok43f
        cu8xO2jxK+LazOrP1TKHcqpXBTvMEvj8UeHStG9PXtyKrxWLCH9okPDVsubM2sCWwNUKnlLf
        NF5q9C5SOuHayrxFNeEK541T79jusb88lBZYeuHp7gv6C5nve6ccPbYr1uyWwqKDs86d8/Cy
        33DtON8W9Ztb+RU233VdMeGs262bC1s3H4zN47/nM+nB5eiET94ufY7rbkyNWL0oLbB4ymJn
        xwN8n0S8fi63WPNGjuPy/iXzRWvmTzQy7d2il6fEUpyRaKjFXFScCADWsXVhtwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xe7o5q5cnGkycImZx7vFvFou/k46x
        W5ze/47FYt5nWYtNj6+xWkzcf5bd4nPvEUaLG3NNHDg8fv+axOjRtsDeY9OqTjaPO9f2sHls
        XlLv8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllq
        kb5dgl7GiiV8BX0SFfPW7mNuYDwi3MXIySEhYCJx+uIR5i5GLg4hgaWMEu9aV7JAJGQkTk5r
        YIWwhSX+XOtigyh6zyjx4dpPsCJeATuJV1u2soHYLAIqEqdmPmOCiAtKnJz5BKxGVCBJ4umB
        TrAaYYFgia9/n4DZzALiEreezAerFxGIlLjWc40ZIn6JUWJ9nyGILSSwl1Hi4QI3EJtNwFCi
        620XWC+ngJXEof5D7BD1ZhJdW7sYIWx5ie1v5zBPYBSaheSMWUjWzULSMgtJywJGllWMIqml
        xbnpucWGesWJucWleel6yfm5mxiB8bft2M/NOxjnvfqod4iRiYPxEKMEB7OSCK/8zGWJQrwp
        iZVVqUX58UWlOanFhxhNgWExkVlKNDkfmADySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNL
        UrNTUwtSi2D6mDg4pRqYki3/XkjIePgvd9Ex62sNHHvuHa44utHr/sHJhx7neStwP7i3dXaR
        24aNlVrdy1bcn/1A5MjNJW+ncvfF3Dm8JclNPsYvYRpXTcaW2uKm1f9LDsq1Hy8QOVjNVnxe
        YWqcB/+hw0bGXnMZZIqdfk6rYDG6H/c7a7fxsRWpe10jeu/dyRGew/Vc31nraX652LHDG+bk
        nb330cd80oLjbF4zmKWPf8n5veh0wSzpn8y3mq6x7Mtlk/jwlffRwWUnV7Yqf35j97LsH+db
        fZ3jhWeXHmZUmTr94bO58zgnsoc/0k9rXWEhqWhU+Lr+xnFGvpebD70Ue3et3s1w2UYDpY1b
        V938LnHZMz5iidKiyloH7kNKLMUZiYZazEXFiQBJYq1HSAMAAA==
X-CMS-MailID: 20211201170548eucas1p2b71c76b3066ac378307e8428f9654882
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211201130836eucas1p2add1ab31da5f5d41d4e5c3e552446ec9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211201130836eucas1p2add1ab31da5f5d41d4e5c3e552446ec9
References: <20211201130505.257379-1-stephan@gerhold.net>
        <CGME20211201130836eucas1p2add1ab31da5f5d41d4e5c3e552446ec9@eucas1p2.samsung.com>
        <20211201130505.257379-2-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01.12.2021 14:05, Stephan Gerhold wrote:
> At the moment, the "qcom-spm-cpuidle" platform device is always created,
> even if none of the CPUs is actually managed by the SPM. On non-qcom
> platforms this will result in infinite probe-deferral due to the
> failing qcom_scm_is_available() call.
>
> To avoid this, look through the CPU DT nodes and check if there is
> actually any CPU managed by a SPM (as indicated by the qcom,saw property).
> It should also be available because e.g. MSM8916 has qcom,saw defined
> but it's typically not enabled with ARM64/PSCI firmwares.
>
> This is needed in preparation of a follow-up change that calls
> qcom_scm_set_warm_boot_addr() a single time before registering any
> cpuidle drivers. Otherwise this call might be made even on devices
> that have this driver enabled but actually make use of PSCI.
>
> Fixes: 60f3692b5f0b ("cpuidle: qcom_spm: Detach state machine from main SPM handling")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Link: https://lore.kernel.org/r/86e3e09f-a8d7-3dff-3fc6-ddd7d30c5d78@samsung.com/
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

I'm fine with this fix.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> Daniel, would be great if you could ack this patch and PATCH 3/4
> (the cpuidle part) if they look good to you. I think it's easiest if Bjorn
> takes them together with the qcom_scm changes through the qcom tree.
>
> Marek had an alternative fix for this [1], the difference in this patch is
> that it avoids creating the platform device entirely if no CPU is managed
> by a SPM.
>
> [1]: https://lore.kernel.org/r/20211020120643.28231-1-m.szyprowski@samsung.com/
> ---
>   drivers/cpuidle/cpuidle-qcom-spm.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
> index 01e77913a414..5f27dcc6c110 100644
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -155,6 +155,22 @@ static struct platform_driver spm_cpuidle_driver = {
>   	},
>   };
>   
> +static bool __init qcom_spm_find_any_cpu(void)
> +{
> +	struct device_node *cpu_node, *saw_node;
> +
> +	for_each_of_cpu_node(cpu_node) {
> +		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
> +		if (of_device_is_available(saw_node)) {
> +			of_node_put(saw_node);
> +			of_node_put(cpu_node);
> +			return true;
> +		}
> +		of_node_put(saw_node);
> +	}
> +	return false;
> +}
> +
>   static int __init qcom_spm_cpuidle_init(void)
>   {
>   	struct platform_device *pdev;
> @@ -164,6 +180,10 @@ static int __init qcom_spm_cpuidle_init(void)
>   	if (ret)
>   		return ret;
>   
> +	/* Make sure there is actually any CPU managed by the SPM */
> +	if (!qcom_spm_find_any_cpu())
> +		return 0;
> +
>   	pdev = platform_device_register_simple("qcom-spm-cpuidle",
>   					       -1, NULL, 0);
>   	if (IS_ERR(pdev)) {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

