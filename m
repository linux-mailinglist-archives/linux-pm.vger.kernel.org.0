Return-Path: <linux-pm+bounces-36517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3855ABF3778
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 22:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD564483A94
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 20:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DB92E0415;
	Mon, 20 Oct 2025 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L22xhfUo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827312DFA21;
	Mon, 20 Oct 2025 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992658; cv=none; b=ttr7sG5c8ut0yDoTJeRzn715sKdWyp3dc6+TYxBFWdjAONb8qN9JjMZEwRdBe147U1RolZ+bmF9m4G6ZNLS6EqTB78wjW3ztIvPo10vk9gTngeYUaw/Nk+jTUD4kxOkJqfenYFgYAe6A7G+6cqMvcpoELsJszKd7GvFFVE2JBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992658; c=relaxed/simple;
	bh=s9q6M3Nz8O4IFWyipi6t77TPJj8JKPI6t+9s5Og4Ybs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WROzaVx5DR4Aj1Mh+mVGMyoDtKhavn47b4/6UCf9OQfx6XXwfTBZT5u72dBGweyXrDqrIREDicSS0qAC95+xCvNX+Gd7YeXOnMnNgLUU1rFCwDS84fqx7SasSX0n/EvVaHGlTz0ALDzJi+PgB6/W6RTy/nvqBQf4ubOOKwgpP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L22xhfUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9208CC113D0;
	Mon, 20 Oct 2025 20:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760992658;
	bh=s9q6M3Nz8O4IFWyipi6t77TPJj8JKPI6t+9s5Og4Ybs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L22xhfUon5IZac6+wKGvK7yb59ZgO4EeY+l+LYKCflSDQUqu+ewLCKIj9TpJO6WO5
	 1rS1yRiYeusLoWHztatdJbfcmoj59LOMAtwJWeadfmHUElqbDbhBCnhIFkuioOZaW/
	 dH4WfNLUbI6sZfr7MIkDndRTGQB4iOXx4gyO3sB0pzEvZczxlANe9uWAKlBP5QHJVM
	 RDhpVSUf7nS1cRMz4xymF8jXLuVThEXN2yy55KaIwX4T7gxd+w6kj/8bbC6WGPPWUG
	 0i9s2zZvAWd1MeGBAptv+Cnk0Fm8pc6+tq6jfV0NKlQL0lH6QYmp9+zzECwGLRDrQb
	 Y3JT/JHZ2eU9Q==
Message-ID: <49258645-d4d8-44a5-a4fc-b403c926a5d1@kernel.org>
Date: Mon, 20 Oct 2025 22:37:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Support dynamic EMC frequency scaling on
 Tegra186/Tegra194
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
 <5d7491b1-8f9a-4040-b854-ff0b94bfd24e@kernel.org>
 <CALHNRZ-okVZ8tzKYa=jqudDu3dZ_Yq1CkeErdcvxi5xJEgJFbg@mail.gmail.com>
 <113725e3-3e82-4921-b045-8d5be3fed8bf@kernel.org>
 <CALHNRZ8r_bg-Pm1ZCoJT9sk++zQcq85R=8N6enL_Vcq=VziNwA@mail.gmail.com>
 <CALHNRZ-2Hv2ix0Hr9veOPWdO=ekgpEWKBWtCiCsQa29DcfdkUA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CALHNRZ-2Hv2ix0Hr9veOPWdO=ekgpEWKBWtCiCsQa29DcfdkUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/10/2025 22:14, Aaron Kling wrote:
> On Sun, Oct 12, 2025 at 9:31 PM Aaron Kling <webgeek1234@gmail.com> wrote:
>>
>> On Sun, Oct 12, 2025 at 9:25 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>> On 13/10/2025 04:18, Aaron Kling wrote:
>>>> On Wed, Oct 8, 2025 at 7:05 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>
>>>>> On 09/09/2025 15:21, Aaron Kling via B4 Relay wrote:
>>>>>> This series borrows the concept used on Tegra234 to scale EMC based on
>>>>>> CPU frequency and applies it to Tegra186 and Tegra194. Except that the
>>>>>> bpmp on those archs does not support bandwidth manager, so the scaling
>>>>>> iteself is handled similar to how Tegra124 currently works.
>>>>>>
>>>>>
>>>>> Nothing improved:
>>>>> https://lore.kernel.org/all/20250902-glittering-toucan-of-feminism-95fd9f@kuoka/
>>>>
>>>> The dt changes should go last. The cpufreq and memory pieces can go in
>>>> either order because the new code won't be used unless the dt pieces
>>>> activate them.
>>>
>>>
>>> Then cpufreq and memory should never have been part of same patchset.
>>> Instead of simple command to apply it, maintainers need multiple steps.
>>> Really, when you send patches, think how this should be handled and how
>>> much effort this needs on maintainer side.
>>
>> To be honest, I was expecting all of these to go through the tegra
>> tree, since all the drivers I touch are owned by the tegra
>> maintainers. But getting stuff moved through that tree has been like
>> pulling teeth recently. So Krzysztof, what's the alternative you're
>> suggesting here?
> 
> What is the expectation for the series here, and related, the tegra210
> actmon series? Everything put together here accomplishes the single
> logical task of enabling dynamic frequency scaling for emc on tegra186
> and tegra194. The driver subsystems do not have hard dependencies in

There are comments from Viresh so I dropped the patchset from my queue.


> that the new driver code has fallbacks to not fail to probe if the
> complementary driver changes are missing. But if I was to split them
> up, how would it work? I send the cpufreq patch by itself, the memory

Please open MAINTAINERS file or read the output of get_maintainers.pl.
This will tell you what is the subsystem here. Currently you mixed a
lot: three subsystems which has only drawbacks. There is no single
benefit of that approach, unless you have dependencies (REAL
dependencies), but you said you don't have such. If you have
dependencies this must be FIRST, the most important thing you mention in
the cover letter. Many maintainers appreciate if you mention in patch
changelogs as well, because they (me included) do not read cover letters.

So if you open the MAINTAINERS file you will find subsystems: cpufreq,
Tegra SoC and memory controllers (where DT bindings belong)

You split your patchset per subsystem, with the difference (explained in
DT submitting patches) is that DT bindings for drivers belong to the
driver subsystem.

The DTS patches using newly introduced bindings should carry lore links
to patchsets with the bindings, so the SoC maintainer can apply them
once bindings hit next.

I also described the entire process before:
https://lore.kernel.org/linux-samsung-soc/CADrjBPq_0nUYRABKpskRF_dhHu+4K=duPVZX==0pr+cjSL_caQ@mail.gmail.com/T/#m2d9130a1342ab201ab49670fa6c858ee3724c83c

so now I repeated it second time. It is the last time I repeat the
basics of organizing patchsets.

> changes in a group, then the dt changes in a group with b4 deps lines
> for the two driver sets? That seems crazy complicated for something

That's pretty standard, nothing complicated. You should have seen
complicated posting here:
https://lore.kernel.org/all/20231121-topic-sm8650-upstream-dt-v3-0-db9d0507ffd3@linaro.org/

We all send multiple patchsets, with or without dependencies.

Best regards,
Krzysztof

