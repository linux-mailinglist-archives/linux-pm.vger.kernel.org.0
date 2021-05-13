Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA6437FD35
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 20:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhEMSZr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 14:25:47 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:31570 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhEMSZr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 14:25:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620930275; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BaXSqLqMDPD3YmeTDdHz61FFopAPciI40QzVEV0Fqwg8H5pn+IJzv7pj/+mARoqrzl
    nBJFfqMaTwC68nJ2Pyt0iUqMg2CPdaMSvYG1ZN7PfPUJXY4pJMuuMVTJ7E9zujy06SVt
    GylIRQO5PK/QQAWtOhTmu+Yrm11iDYwWwCcQ808JjnWtAwTUSz8Ops9omx7jeHD4h1Hy
    e7R1ek+PN8H3N6u07V+rPqxK5roFDKh6XB5jBTq5mUOqZV+n0DSlelRmJAGEoPH66XoB
    PxKyar7sfsYmm0m2i0L0oDbuW5DBML3WwQ15KgZUQCam5TCoBH3dNUedK01gYNRe2/NJ
    +2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620930275;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=La2k3otlW4DaTcwOkpooer6L76+dh9I6/tmKprhZSh4=;
    b=d/9InNVUIWZT1VxK67TwIcYB/qawmlRR8rrtaCTqjhRmJGkrhmHyW51HbHSzOmELpm
    moNL79FzqitaC2udJa49F/Ygdh7k1Hz4J9uLwUrEeeL/akSvLh7Sn5MwYZSnR4SCczF5
    H7YJcHyR1lt+r5IzDoMzUWIwO8OeNDtrH94PX9OgDAVS0aSywCAYwW8mDPSMLw5sP5tV
    2k6fmXdyBIN4vfT2mk6MecvI11b1ASH9wVEd1TAC+ndp60Ct4m8i9OGaMLR+uVej2jgI
    N5DX7BBAMmRc9a84UuNmLyj+bXFw3FmIQB2udwqXGzgFpld6NV93Lwp2astsXe77MtaC
    sGGg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620930275;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=La2k3otlW4DaTcwOkpooer6L76+dh9I6/tmKprhZSh4=;
    b=WKcOGm1ZNWj5TzAudxvR5g0HRpzlXyWcR7t3UjWIUX8ub/Mc1hFqKSjGkjjxUAg63a
    stwZ0QAlOUYhxevJBKNfFZ4hp1i5roOGpVTFYLxAc+rAc3iUgCPADQYlijlJKywjRimF
    4V40lHfk2787klBLqzFSmFrdpSSGjzJ0XdinvDSNMzFB98AaeFbscMxURLFyG7Rbc7Ze
    03bbhqmPTtIqCHwb+uwWRy5J/JhC0fxlT7K1k6S3OqRd+iXeMTelx0ywrW7PFwv4K4rt
    ZW8VkffLGbtF1wH1UM277tRA1M9Puyx0lx+vLq8pNE/JAI7N0weng9u4b2VsUhCZXEDO
    lgmw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6IczCBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.25.7 DYNA|AUTH)
    with ESMTPSA id j06c13x4DIOZD6V
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 13 May 2021 20:24:35 +0200 (CEST)
Date:   Thu, 13 May 2021 20:24:30 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Sterba <dsterba@suse.com>, Jens Axboe <axboe@kernel.dk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] cpuidle: qcom: Add SPM register data for APQ8026 and
 MSM8226
Message-ID: <YJ1u3syIquKRyuv2@gerhold.net>
References: <20210513150150.51464-1-bartosz.dudziak@snejp.pl>
 <20210513150150.51464-2-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513150150.51464-2-bartosz.dudziak@snejp.pl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thu, May 13, 2021 at 05:01:50PM +0200, Bartosz Dudziak wrote:
> Add APQ8026 and MSM8226 SoCs register data to SPM AVS Wrapper 2 (SAW2)
> power controller driver.
> 
> Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
> ---
>  drivers/cpuidle/cpuidle-qcom-spm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
> index adf91a6e4d..9711a98d68 100644
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -87,6 +87,18 @@ static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
>  	.start_index[PM_SLEEP_MODE_SPC] = 3,
>  };
>  
> +/* SPM register data for 8026, 8226 */
> +static const struct spm_reg_data spm_reg_8x26_cpu  = {
> +	.reg_offset = spm_reg_offset_v2_1,
> +	.spm_cfg = 0x0,
> +	.spm_dly = 0x3C102800,
> +	.seq = { 0x60, 0x03, 0x60, 0x0B, 0x0F, 0x20, 0x10, 0x80, 0x30, 0x90,
> +		0x5B, 0x60, 0x03, 0x60, 0x3B, 0x76, 0x76, 0x0B, 0x94, 0x5B,
> +		0x80, 0x10, 0x26, 0x30, 0x0F },
> +	.start_index[PM_SLEEP_MODE_STBY] = 0,
> +	.start_index[PM_SLEEP_MODE_SPC] = 5,
> +};
> +
>  static const u8 spm_reg_offset_v1_1[SPM_REG_NR] = {
>  	[SPM_REG_CFG]		= 0x08,
>  	[SPM_REG_SPM_CTL]	= 0x20,
> @@ -259,6 +271,10 @@ static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
>  }
>  
>  static const struct of_device_id spm_match_table[] = {
> +	{ .compatible = "qcom,apq8026-saw2-v2.1-cpu",
> +	  .data = &spm_reg_8x26_cpu },
> +	{ .compatible = "qcom,msm8226-saw2-v2.1-cpu",
> +	  .data = &spm_reg_8x26_cpu },

What is the reason for having a separate compatible for APQ8026?

If the difference between MSM8226 and APQ8026 is similar to other qcom
SoCs (just lack of modem), both will end up using the same device tree
include anyway. Then it's easier to have both use qcom,msm8226-saw2-v2.1-cpu.

Thanks,
Stephan
