Return-Path: <linux-pm+bounces-23430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBC6A4E8F6
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 18:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023A08E0864
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2979C2836A8;
	Tue,  4 Mar 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVDm6mrH"
X-Original-To: linux-pm@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B21427E1BE
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104996; cv=fail; b=JwZ7cp0uXcvWb9tXM4IyNlisyfk7EXAaCVizdy2p6ulYwfgdXR8WC4kGqL39FOLVyikKiqbD86f4rljmFIviThN6dTJ6vbuTmhkGUZYoMvsJFw6oPg9YfO79MBRO/AysYN7UQsQTApTHIGV1n5b9Eg/20ipiOcW92URAuo4YHLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104996; c=relaxed/simple;
	bh=fJSn3lSDTlK+8ZW+kH3QUnzoBFI39rQvsG9xd03tdGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuYvvaHC6GeP5rJRFTohQ/OVyoYQe+E02XT/OQFa2Zr0fLRv4cVfu4h2Nd6qHdjj2HB4OLaZVUXVX08lgHEUYhIxLVSB1MH40I71sMzEvJGQF6YRFoUuKMYWCQUQ3MEJrOwzXj7Zn55PbvggitvgM1gwQkcTzPgTIQYXkLMUwfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVDm6mrH reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id C01E540CEC9A
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 19:16:32 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nVDm6mrH
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6ghN4nWSzG2hl
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 19:13:08 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id C7A4142737; Tue,  4 Mar 2025 19:12:56 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVDm6mrH
X-Envelope-From: <linux-kernel+bounces-541147-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVDm6mrH
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id BCEA942CD8
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:27:58 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 52AC12DCEF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:27:58 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BB53B381A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9024A1EFFA3;
	Mon,  3 Mar 2025 08:23:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449631EF370;
	Mon,  3 Mar 2025 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990224; cv=none; b=YeNpwptjQ6U6jfGrrQ4F8XoyNBWy3PsMWutDR1se33zfZVIgbrkhMRjxQjE2s0yC8eBNKg4kI8lgGWvU1Svgm6PGXyLvo2EbQLqdk3Y/9oLtT2fWC42+zzkdkUvVGtsNmUMaB8oILDEk34m2hehRcrn+otTCC4vApBeTspbKlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990224; c=relaxed/simple;
	bh=JBYtPPedySIRtCIdRicfOKbQHdjbOfdWis8gttwCsKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6FvrZqC+W6V46yPb7Ff2eN6i0EMkbFPh34rTayNVUaJgabFpd/9qkyZsX5igcK8kk7b5IP01g/jrDjs/5peB0zUHk8qGYjbKeAAdZgbNKy79DCn6UcbgKQEMW8H4wXjlxSm3ptd4fV21BO1C2a1EY/2vKaJegxgi4BaEieV08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVDm6mrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC04C4CED6;
	Mon,  3 Mar 2025 08:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740990223;
	bh=JBYtPPedySIRtCIdRicfOKbQHdjbOfdWis8gttwCsKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nVDm6mrH12QLK3/qUGEVPT3+GKwhphezMCb3UYIFD2ammHyvoXLfegpFXS35yl7wP
	 iXAtbjJ81a3G3cAnJPMh2gX7ThMNXotuiezB1R2iwBozQKUtI/az9KcGpGrKa0hbfX
	 sxIFGSWyqRiLFmiKd/sTiAynk6ZlSoW0DEPRoCOz6hRNJiNqnkJO8N8YaYaj9VEbrL
	 I+RMLenU3E2DKzLx13fWN3rbKamCKZf30X6qYN21gC7d4+1b1HheP+KW4go/pQ8uTh
	 pzlUSNBjBBx3Y1gdu86czAZdr9zQiESi4E2sLVt5KZcR86KqZIs6zji4qpoCidL2Gn
	 GrbFt881OjQNQ==
Message-ID: <a091f085-a7f0-4aaa-997d-cd478764c18a@kernel.org>
Date: Mon, 3 Mar 2025 09:23:38 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Document Maxim MAX8971
 charger
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250226093700.44726-1-clamor95@gmail.com>
 <20250226093700.44726-2-clamor95@gmail.com>
 <20250227-cherubic-mantis-from-betelgeuse-86f5ff@krzk-bin>
 <CAPVz0n2kfxTJUkqrtLia6xBJ8t+fwjujjsc9k=mOk-P06bJH7A@mail.gmail.com>
 <f83b2a95-e8f6-4e16-bd7f-f7dc96264c04@kernel.org>
 <CAPVz0n0KVE8baFyGSgM+0rNfY8+Y2LFZbAhHHzPWTV358gc+Bw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAPVz0n0KVE8baFyGSgM+0rNfY8+Y2LFZbAhHHzPWTV358gc+Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6ghN4nWSzG2hl
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741709675.97099@WMFC7BjvpXJzhbAGgajO0Q
X-ITU-MailScanner-SpamCheck: not spam

On 03/03/2025 09:13, Svyatoslav Ryhel wrote:
> =D0=BF=D0=BD, 3 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 09:52 K=
rzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>>
>> On 27/02/2025 12:03, Svyatoslav Ryhel wrote:
>>> =D1=87=D1=82, 27 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 12:4=
5 Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>>>>
>>>> On Wed, Feb 26, 2025 at 11:36:59AM +0200, Svyatoslav Ryhel wrote:
>>>>> +  maxim,fcharge-current-limit-microamp:
>>>>> +    description:
>>>>> +      Fast-Charge current limit
>>>>> +    minimum: 250000
>>>>> +    default: 500000
>>>>> +    maximum: 1550000
>>>>> +
>>>>> +  maxim,fcharge-timer-hours:
>>>>> +    description:
>>>>> +      Fast-Charge timer in hours. Setting this value 3 and lower o=
r 11 and higher
>>>>> +      will disable Fast-Charge timer.
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    default: 5
>>>>
>>>> You still did not answer why this is board specific. This was reject=
ed
>>>> in the past because of that reason and nothing here changed. Nothing

Where are the arguments to existing/previous decisions?

>>>> will change without detailed explanation, so use other interfaces if=
 you

Again, where is detailed explanation why time is determined per board,
unlike previously agreed that it is not?

>>>> need user-space to configure it (see other drivers, e.g. maxim)




>>>>
>>>
>>> Btw, I have used this awesome example you have provided. Take a look
>>
>> Where did I provide this example?
>>
>=20
> Its presence in the docs is an example on its no? You have explicitly
> told to check other maxim devices, I did so, they all have similar set
> of convifurations.

Choose rather later or latest, not 12 YO, binding as an example.

>=20
>>>
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml=
?h=3Dv6.14-rc4
>>
>> I opened it and I do not see anything about time. Please point to
>> specific line.
>>
>> But regardless, how did I propose to use 12 year old binding? Where di=
d
>> I suggest that one?
>>
>>>
>>> Oh, I wonder why it uses so much values which duplicate battery? I
>>> know, it lacks battery, I assume that is why?
>>
>> No. You added to DT something which is not a hardware property, but
>> user-space choice or policy.
>>
>=20
> It is NOT a user-space choice or policy!
Previous discussions on the lists - since you mention 12 year old
binding, so also discussions 12 years ago - determined that they are
closer to them than board configuration.

I already said - this was rejected in the past - so now I am repeating
myself.

You did not bring any arguments just keep repeating "no", so I suggest
reading previous discussions and coming with arguments against them.

Best regards,
Krzysztof


