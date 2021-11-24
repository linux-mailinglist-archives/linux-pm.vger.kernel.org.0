Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AF445C50C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 14:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351585AbhKXNyo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 08:54:44 -0500
Received: from foss.arm.com ([217.140.110.172]:38708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352156AbhKXNwQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Nov 2021 08:52:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 627C6ED1;
        Wed, 24 Nov 2021 05:49:06 -0800 (PST)
Received: from [10.57.56.56] (unknown [10.57.56.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46E3F3F73B;
        Wed, 24 Nov 2021 05:49:04 -0800 (PST)
Message-ID: <bf994aa8-df18-22d0-e718-2c8b406a5cc8@arm.com>
Date:   Wed, 24 Nov 2021 13:49:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/5] arm64: dts: rockchip: Add powerzones definition for
 rock960
Content-Language: en-GB
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     robh@kernel.org, arnd@linaro.org, heiko@sntech.de,
        ulf.hansson@linaro.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
References: <20211124125506.2971069-1-daniel.lezcano@linaro.org>
 <20211124125506.2971069-2-daniel.lezcano@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211124125506.2971069-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-11-24 12:55, Daniel Lezcano wrote:
> Add the powerzones description. This first step introduces the big,
> the little and the gpu as a powerzone place.

These look more like SoC-level properties than board-level ones - should 
they be in rk3399.dtsi?

Robin.

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   .../boot/dts/rockchip/rk3399-rock960.dts      | 45 +++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> index 1a23e8f3cdf6..83540bdb64cd 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> @@ -61,6 +61,51 @@ bt_active_led: led-6 {
>   		};
>   	};
>   
> +	powerzones {
> +
> +		PKG_PZ: pkg {
> +			#powerzone-cells = <0>;
> +                        powerzone = <&SOC_PZ>;
> +		};
> +
> +		SOC_PZ: soc {
> +		};
> +	};
> +};
> +
> +&cpu_b0 {
> +	#powerzone-cells = <0>;
> +	powerzone = <&PKG_PZ>;
> +};
> +
> +&cpu_b1 {
> +	#powerzone-cells = <0>;
> +	powerzone = <&PKG_PZ>;
> +};
> +
> +&cpu_l0 {
> +	#powerzone-cells = <0>;
> +	powerzone = <&PKG_PZ>;
> +};
> +
> +&cpu_l1 {
> +	#powerzone-cells = <0>;
> +	powerzone = <&PKG_PZ>;
> +};
> +
> +&cpu_l2 {
> +	#powerzone-cells = <0>;
> +	powerzone = <&PKG_PZ>;
> +};
> +
> +&cpu_l3 {
> +	#powerzone-cells = <0>;
> +	powerzone = <&PKG_PZ>;
> +};
> +
> +&gpu {
> +	#powerzone-cells = <0>;
> +	powerzone = <&PKG_PZ>;
>   };
>   
>   &cpu_alert0 {
> 
