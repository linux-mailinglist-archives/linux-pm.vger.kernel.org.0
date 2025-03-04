Return-Path: <linux-pm+bounces-23348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC1BA4D54A
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 08:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D750189B96C
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 07:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF931F875B;
	Tue,  4 Mar 2025 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRjugh86"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191181F5429;
	Tue,  4 Mar 2025 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074288; cv=none; b=IHuqac3aB1NKWD8dYuyKlV631Q7Kj0er74zy825Y1e1zk7hdHQ59WYTKzp4c7/mn9GwZmqIZ6alfPyC7/cEZUkfBjcZZprjh4FlTmmDy2z3LfwH0kS705dcFgPGIM/3IKhfGguC2bNimcQ2c6F9gj8Y0Az4G26IMOfeIo7rU9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074288; c=relaxed/simple;
	bh=9bxpUZMc/I1HEv4SLq+lQIM/QZ/o1hTAwys66NHVlqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwcGTLi4ZrrKnnXCg/eBKwHHA38E52GnOui8oJs1kzAqsmZ59CJxQebjHNRXR/VMT0SDAtfzNqG4TVc2pQwkxbduSB1FUsiTZbdvbERdCZsL7RrKIoGZvokqQv/qy2b8ShtlUpb3tMpIJHmp7uaSWibUCRd2VSTo9/297Obt/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRjugh86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAF5C4CEE9;
	Tue,  4 Mar 2025 07:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741074287;
	bh=9bxpUZMc/I1HEv4SLq+lQIM/QZ/o1hTAwys66NHVlqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NRjugh86mZu6/NUJQyJD/KAXr6dzb2sdrCV7inzMKonWGk+8VCLebAzk1ZwF5VEZW
	 JOXLDwCNuoOWHmytXIuINoCPIzuAyld8OFIoSXGgPcWWxKbhHNwBcgk9W8ZLy+RZNA
	 3MrWRXkyDJOrvYfZEowwE7cCuy9/xU3sEzSB1AnFX8beMNuL7sguG3TlVCBngt84R8
	 Vno2FlV4FbHHgetK+/qVsT785mbh1Yr9pM561RHJ/pmWoqOErTNR8wTK6uUypTGHvQ
	 O1s74qQo8vphe8V6Ex1tcbsFhEOZcOEwIt9BfHdCzooRlwqI458jQxAaFUWmo5cmxP
	 h+zRCmlOl/ncQ==
Message-ID: <3190de22-67eb-4f28-b7f1-27bcd8db1e9a@kernel.org>
Date: Tue, 4 Mar 2025 08:44:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/21] Enable drm/imagination BXM-4-64 Support for
 LicheePi 4A
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
 wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
 matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 ulf.hansson@linaro.org, jszhang@kernel.org, p.zabel@pengutronix.de,
 m.szyprowski@samsung.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org
References: <CGME20250219140249eucas1p1291eb86c932373c847a3314ae54789d5@eucas1p1.samsung.com>
 <20250219140239.1378758-1-m.wilczynski@samsung.com>
 <20250221-eminent-squirrel-of-honor-dee80d@krzk-bin>
 <90d0d409-f374-4e06-bc69-b9bf0622959d@samsung.com>
 <7ba53937-7922-41da-a7ed-909ce620db1f@kernel.org>
 <09411368-cd76-479f-ade3-5a87d3f9be38@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <09411368-cd76-479f-ade3-5a87d3f9be38@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/03/2025 08:38, Michal Wilczynski wrote:
> 
> 
> On 3/3/25 18:43, Krzysztof Kozlowski wrote:
>> On 03/03/2025 09:38, Michal Wilczynski wrote:
>>>
>>>
>>> On 2/21/25 10:12, Krzysztof Kozlowski wrote:
>>>> On Wed, Feb 19, 2025 at 03:02:18PM +0100, Michal Wilczynski wrote:
>>>>> The LicheePi 4A board, featuring the T-HEAD TH1520 SoC, includes an Imagination
>>>>> Technologies BXM-4-64 GPU. Initial support for this GPU was provided through a
>>>>> downstream driver [1]. Recently, efforts have been made to upstream support for
>>>>> the Rogue family GPUs, which the BXM-4-64 is part of [2].
>>>>>
>>>>> While the initial upstream driver focused on the AXE-1-16 GPU, newer patches
>>>>> have introduced support for the BXS-4-64 GPU [3]. The modern upstream
>>>>> drm/imagination driver is expected to support the BXM-4-64 as well [4][5]. As
>>>>> this support is being developed, it's crucial to upstream the necessary glue
>>>>> code including clock and power-domain drivers so they're ready for integration
>>>>> with the drm/imagination driver.
>>>>>
>>>>
>>>> This is v5 of big patchset which became huge. I understand you did like
>>>> that for v1 which was RFC. But it stopped being RFC.
>>>>
>>>> Split your patchset, keeping versioning and changelog, per subsystem.
>>>
>>> Sorry for the late reply—I didn't have access to email. I agree with
>>> your suggestion and will send the clock changes, firmware/power domain,
>>> reset, and drm/imagination updates as separate patchsets for merging.
>>
>>
>> How did you implement above comment? You did the split, right? Where is
>> versioning and where are changelogs?
> 
> So I thought the sub-series should be versioned independently from v1 ?

Keep the versioning. Keep the changelog.

You now versioned your new set independently, so I don't understand your
question.

> Then linked the previous discussions in the cover letter, without
> copying them.

Nothing said this is the same patchset. You just mentioned some "bigger
series" cover letter. How some other bigger series is anyhow related?
And how can I find relevant pieces there?

You are supposed to make it easy for reviewers, not difficult.

Best regards,
Krzysztof

