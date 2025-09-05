Return-Path: <linux-pm+bounces-33975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E7BB4554F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 12:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD81658423B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 10:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD698311C13;
	Fri,  5 Sep 2025 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3MZ1pvT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00ED30E855;
	Fri,  5 Sep 2025 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069292; cv=none; b=ZRQe+lBxrVIhRwGvW3cDB/ycrI6XG1KK0sevg6KYKxG0Mc1793YfedPbGR4A3INXOJ7RVdXyFUwida7J1j7YB0k8nNxCqRmwnuAQtyv8/2Q7tVXnRJ9+PSc+nk4hWJvtB4Gp5b2ylDsIlVeYuBnyObXP/2nhsuU6BhSHKUynuS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069292; c=relaxed/simple;
	bh=3BMIevIPv5UuOOVHMNBtqTYriH3klwwZDMVfFyThPqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfCmtdCLVJugzazECipCOe2ZPUCe6F7s+KsCu+Z312fA1dL6REhdFCJfUnYwgGqzvTp15o2G/siQI6JEiBptZQrzQigPMUy3sI/7jhwaG0OSb1AlryugweTxe+YTr+nSd/O1oktpl2xqT6fDJmNTN6ykeeI3dBshHa/ID43DNSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3MZ1pvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566ADC4CEF7;
	Fri,  5 Sep 2025 10:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757069291;
	bh=3BMIevIPv5UuOOVHMNBtqTYriH3klwwZDMVfFyThPqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k3MZ1pvTn1XZL5vGExYPBFL6Zz81+3p/Ox2kKbNWCZF7ueMAAtcLe3R6eckSxyqqx
	 NZMxnGzeKsUhl/5SmKeuJfHMUxwRHkZmFctIlWaJXM4VHeaeK5TDDpvz+1iO/k68T7
	 WMvSrYxYDWX9CDOScP+cTpx2aOFrBUmI3t7naO/c1jpYx7/SiT7ava4PD5fnDezox4
	 MWG2IjyYELCMI9BiXiwegmCxM52zhEFJJzAnbR0OoSCNEs2U8xT+EuhKUt2PEt5A5B
	 JWYYehK9X3ReHenH/HyUx/N0IEb5yCML4KWhVEALwLjzCA6bq6Ua2+OiVofThmLfKi
	 n1gsAiHLouhzA==
Message-ID: <dc42cadc-bfc9-4473-ad90-aaab88101b49@kernel.org>
Date: Fri, 5 Sep 2025 12:48:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] thermal: versal-thermal: Support thermal management
 in AI Engine
To: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc: Anish Kadamathikuttiyil Karthikeyan Pillai
 <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba
 <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Salih Erim <salih.erim@amd.com>, Zhang Rui <rui.zhang@intel.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <cover.1757061697.git.michal.simek@amd.com>
 <3636099d5d0b31ebf232a5b2e741f0ff7e7e1631.1757061697.git.michal.simek@amd.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <3636099d5d0b31ebf232a5b2e741f0ff7e7e1631.1757061697.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2025 10:41, Michal Simek wrote:
> +	vti->channel = iio_channel_get(NULL, SYSMON_TEMP_CH_NAME);
> +	if (IS_ERR(vti->channel)) {
> +		vti->num_aie_channels = 0;
> +		versal_thermal_iio_chan_release(vti);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(vti->channel),
> +							"IIO channel %s not found\n",
> +							SYSMON_TEMP_CH_NAME);
> +	}
> +
>  	vti->tzd = devm_thermal_of_zone_register(&pdev->dev, 0, vti, &thermal_zone_ops);
>  	if (IS_ERR(vti->tzd))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(vti->tzd),
>  				     "Thermal zone sensor register failed\n");
>  
> -	return devm_thermal_add_hwmon_sysfs(&pdev->dev, vti->tzd);
> +	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, vti->tzd);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to add hwmon sysfs for sysmon temp\n");
> +
> +	sysmon_node = of_find_node_by_name(NULL, "sysmon");

Undocumented ABI. Please don't do that. sysmon is not an approved name
and for sure can be changed anytime to anything.

Phandles express relationships usually.


> +	if (sysmon_node) {
> +		ret = of_property_read_u32(sysmon_node, "xlnx,numaiechannels",
> +					   &num_aie_channels);
> +		if (ret < 0)
> +			num_aie_channels = 0;
> +	}
> +
> +	if (num_aie_channels > 0) {
> +		aie_temp_chan_names = devm_kcalloc(&pdev->dev, num_aie_channels,
> +						   sizeof(*aie_temp_chan_names),
> +						   GFP_KERNEL);
> +		if (!aie_temp_chan_names)
> +			return -ENOMEM;
> +
> +		for_each_child_of_node(sysmon_node, child_node) {
> +			if (of_property_present(child_node, "xlnx,aie-temp")) {
> +				ret = of_property_read_string(child_node, "xlnx,name",
> +							      &aie_temp_chan_name);
> +				if (ret < 0) {
> +					of_node_put(child_node);
> +					return ret;
> +				}
> +				aie_temp_chan_names[aie_ch_index] = aie_temp_chan_name;
> +				aie_ch_index++;
> +			}
> +		}
> +
> +		/* Allocate memory for the dynamic aie temperature channels */
> +		vti->channel_aie = devm_kcalloc(&pdev->dev, num_aie_channels,
> +						sizeof(*vti->channel_aie), GFP_KERNEL);
> +		if (!vti->channel_aie)
> +			return -ENOMEM;
> +
> +		for (aie_ch_index = 0; aie_ch_index < num_aie_channels; aie_ch_index++) {
> +			vti->channel_aie[aie_ch_index] =
> +			    iio_channel_get(NULL, aie_temp_chan_names[aie_ch_index]);
> +			if (IS_ERR(vti->channel_aie[aie_ch_index])) {
> +				vti->num_aie_channels = aie_ch_index + 1;
> +				versal_thermal_iio_chan_release(vti);
> +				return dev_err_probe(&pdev->dev,
> +						     PTR_ERR(vti->channel_aie[aie_ch_index]),
> +						     "IIO AIE TEMP channel %s not found\n",
> +						     aie_temp_chan_names[aie_ch_index]);
> +			}
> +		}
> +
> +		vti->tzd_aie = devm_thermal_of_zone_register(&pdev->dev, 1, vti,
> +							     &thermal_zone_ops_aie);
> +		if (IS_ERR(vti->tzd_aie))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(vti->tzd_aie),
> +					      "Failed to register thermal zone aie temp\n");
> +
> +		ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, vti->tzd_aie);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Failed to add hwmon sysfs for aie temp\n");
> +	}
> +	vti->num_aie_channels = num_aie_channels;
> +	platform_set_drvdata(pdev, vti);
> +	return 0;
> +}
> +
> +static void versal_thermal_remove(struct platform_device *pdev)
> +{
> +	struct versal_thermal_info *vti = platform_get_drvdata(pdev);
> +
> +	versal_thermal_iio_chan_release(vti);

Don't mix non-devm with devm. This should be a proper devm cleanup action.



Best regards,
Krzysztof

