Return-Path: <linux-pm+bounces-32656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39B1B2CB94
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 20:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3572D17D76E
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE6830EF74;
	Tue, 19 Aug 2025 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EalDzgoN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C15130E0F4;
	Tue, 19 Aug 2025 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626583; cv=none; b=qCfFObCiNTqsudI1X2VkevdR6r2hx34P5WIJkxH1au+kcZ58o5wa/6l3Yq0JnKWQmswZdaosDwaayK5ppU83jAJm8ALwpt8TiGs+dGRTKeqT1sRb4n+SYL2kr/m9Mg3iXTzV5cGNgQ8TBeSulwf3Brcc1JxGM4TcyxBlDeFpCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626583; c=relaxed/simple;
	bh=RlZTJUqIlimT1tWCSSY0h8X/eWmkIxu4Et0KQlg5A2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyxK+h0Ip/RoRa5zw8+sWY5xDwAZWjqNFaixKcYTDqKG945TCWKhxOHGduJv0CsOFAWeyxf8lnluU1uaCTRnqGYHk88l+qF4lvqwyOmQnTTa3TUQ0i73vUIcpO2Y+tUKFdUg7jS+6ZoZZ9zOOR3B/0XstiGgn0ooODmfykuDXsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EalDzgoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE235C4CEF1;
	Tue, 19 Aug 2025 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755626583;
	bh=RlZTJUqIlimT1tWCSSY0h8X/eWmkIxu4Et0KQlg5A2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EalDzgoN/7Y3KAbfB4cazq6wZtBpmRvual893K1SJmmx/DuhYsrrSTe53FFGHmBfL
	 tTbyh7LaaK15dJga2iRCqqP/cUkNp0FsKPFAaesZFufl8QUG2q657Gl64iRM6B6nDP
	 rhKDoQil9Fm00Wn0UseOwl1yllT8NTIVUZFp8VFWOxWJdO/deOAo8jFjFKPHYYLv97
	 enC2fFWmd8TKrbJU3HZHStalauGg1/kCCH1/G9umbauTRb/lCst9NCMod2cGMkkQMR
	 dLSUbvodpJ2gGgGiK3PJSFA6FuE3sgpHo8Py25nojEndpSK+7qkFDQAX71+MKlULbO
	 LbnZhJafrZ8wA==
Message-ID: <36974682-c8f1-4bcd-91f3-255c6332c0fe@kernel.org>
Date: Tue, 19 Aug 2025 21:02:57 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Glymur SoC
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mike Tipton <mike.tipton@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
 <20250814-glymur-icc-v2-1-596cca6b6015@oss.qualcomm.com>
 <CAL_JsqL+C1VueQjrKra8fNTd-2k=gkoy-jA9uuQOhuyRMbQroQ@mail.gmail.com>
 <363db534-92a2-4108-8a41-8e07ec22513d@kernel.org>
 <09247b50-05c4-40ff-9d9e-51e36846996d@kernel.org>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <09247b50-05c4-40ff-9d9e-51e36846996d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/25 7:03 PM, Krzysztof Kozlowski wrote:
> On 19/08/2025 15:46, Georgi Djakov wrote:
>> On 8/19/25 4:31 PM, Rob Herring wrote:
>>> On Thu, Aug 14, 2025 at 9:54 AM Raviteja Laggyshetty
>>> <raviteja.laggyshetty@oss.qualcomm.com> wrote:
>>>>
>>>> Document the RPMh Network-On-Chip Interconnect in Glymur platform.
>>>>
>>>> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>>>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/interconnect/qcom,glymur-rpmh.yaml    | 172 +++++++++++++++++
>>>>    .../dt-bindings/interconnect/qcom,glymur-rpmh.h    | 205 +++++++++++++++++++++
>>>>    2 files changed, 377 insertions(+)
>>>
>>> This is breaking linux-next "make dt_binding_check". Looks like the
>>> clock header dependency in the example is not applied. Please drop
>>> this until the dependency is there.
>>
>> Thanks! And now i see why my script didn't catch this... now fixed and
>> patch dropped.
> 
> What are you using to apply patches? Because b4 would pull all
> dependencies, which would brake your branch as well, but at least you
> would see something odd happening here.

I am using b4, but in cherry-pick mode, so i just pipe the current email to
it. And i also noticed the prerequisite-change-id lines and the dependency
on gcc, but my local scripts (that do all kinds of checks) passed, because
of a bug that didn't properly log the dt_binding_check error, so i thought
the dependency is there. I recently modified it to run with not just the
DT_SCHEMA_FILES="Documentation/devicetree/bindings/interconnect/" but with
a few more schemas and very likely i introduced the logging bug at that time.

Thanks,
Georgi

