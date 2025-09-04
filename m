Return-Path: <linux-pm+bounces-33813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90344B4356F
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 10:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EB11707F2
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 08:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E3B2C08D9;
	Thu,  4 Sep 2025 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmFoytlr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ECB2BEFE8;
	Thu,  4 Sep 2025 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973974; cv=none; b=SKtBDwSw0vOEq3rjZGa0DZMDWbFToRTs3OAQa+yaqecvpC/OIE7z/h3c/j5FkxYC2eLEDKjxqrQamukT0219KRDA8uuUCGVWj/V7siC+p2AqeFpYN/chaRGcuA+CU8S6SMNd9POHuHdKWBReXjtSmh73EXYTCbRiBl6nJR/Dw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973974; c=relaxed/simple;
	bh=kxMA6xJIchs9QR1tfO7hgVmWfcdv0CoNQonnp5feJiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDGUBSocC5l8WAzr/4qUa/qCLzNzGmSH7Oxle9/6qN+nsjcu8M7ua0t08jM6DY2t4VGRFIlzlLAYcTq6191zMppIcPSjJNXD9CXSuOYX7oNZaN9tKLgltyFP4ZpM6TkNn/FabkxPRtRbj1RkPk1An/bN/TVkqL0UITf5qKWbBXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmFoytlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B01C4CEF0;
	Thu,  4 Sep 2025 08:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756973974;
	bh=kxMA6xJIchs9QR1tfO7hgVmWfcdv0CoNQonnp5feJiU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pmFoytlrB60TuzrpAsR5wdSCNjdICXeOP+kFtNbfcpuUsFZNrj/dlrtSbLiRxNHCt
	 WvJ1kfQmjsmELWl3mCa7Ptd7+4zagRgZkj6rY+8veiUupCeHu6kFQREvU8nXOsYG1m
	 vaJhW91XH9hO5tuQaPpaIraXRCFEZUwpwMuVCWzTmQvnzSvJQ8frE8KOiQ04mvx279
	 Ml4X1THzPtoEv1qmJsyeYJVpphzSOhndH7OQdDTxF4vcCN9BaNikA1IAJ6oJBvoNtV
	 FoqlfUTF0kfHaWGjcCGrObVyf6SSzTgq5+BEPZxMXZgKP15fM/Zv3wf56Ueppn4QMt
	 tJ6g215RFgbEw==
Message-ID: <08062eb7-1b7d-4fc3-86ea-af70069065eb@kernel.org>
Date: Thu, 4 Sep 2025 10:19:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Support dynamic EMC frequency scaling on
 Tegra186/Tegra194
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
 <20250902-glittering-toucan-of-feminism-95fd9f@kuoka>
 <CALHNRZ_CNvq_srzBZytrO6ZReg81Z6g_-Sa+=26kBEHx_c8WQA@mail.gmail.com>
 <47c7adc9-fa91-4d4e-9be4-912623c627d6@kernel.org>
 <CALHNRZ8rxyRvb1GCifeXRKjPkkBE+sK6VnPc2nS01iZV_NcjaQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CALHNRZ8rxyRvb1GCifeXRKjPkkBE+sK6VnPc2nS01iZV_NcjaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/09/2025 08:37, Aaron Kling wrote:
> On Wed, Sep 3, 2025 at 1:20 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 02/09/2025 18:51, Aaron Kling wrote:
>>> On Tue, Sep 2, 2025 at 3:23 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On Sun, Aug 31, 2025 at 10:33:48PM -0500, Aaron Kling wrote:
>>>>> This series borrows the concept used on Tegra234 to scale EMC based on
>>>>> CPU frequency and applies it to Tegra186 and Tegra194. Except that the
>>>>> bpmp on those archs does not support bandwidth manager, so the scaling
>>>>> iteself is handled similar to how Tegra124 currently works.
>>>>>
>>>>
>>>> Three different subsystems and no single explanation of dependencies and
>>>> how this can be merged.
>>>
>>> The only cross-subsystem hard dependency is that patches 5 and 6 need
>>> patches 1 and 2 respectively. Patch 5 logically needs patch 3 to
>>> operate as expected, but there should not be compile compile or probe
>>> failures if those are out of order. How would you expect this to be
>>> presented in a cover letter?
>>
>> Also, placing cpufreq patch between two memory controller patches means
>> you really make it more difficult to apply it for the maintainers.
>> Really, think thoroughly how this patchset is supposed to be read.
> 
> This is making me more confused. My understanding was that a series
> like this that has binding, driver, and dt changes would flow like
> that: all bindings first, all driver changes in the middle, and all dt

You mix completely independent subsystems, that's the main problem.
Don't send v3 before you understand it or we finish the discussion here.

> changes last. Are you suggesting that this should be: cpufreq driver
> -> bindings -> memory drivers -> dt? Are the bindings supposed to be
> pulled with the driver changes? I had understood those to be managed
> separately.
What does the submitting patches doc in DT say?

Best regards,
Krzysztof

