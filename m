Return-Path: <linux-pm+bounces-23369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B800A4E12B
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A7B16D015
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 14:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B501125F7AC;
	Tue,  4 Mar 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdDML3sc"
X-Original-To: linux-pm@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D3B25EFB7
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098705; cv=pass; b=GrZj1gbuJfgtFnK2ekDOiuePUyjZbfrtxUDA331eEWYVD+VL8D3Vq0GJkoP748bgDlTfKZO+4EVMiZJQCsjbkLwgpumO+rUXmw5j+OOb7UxuP+JRBswUeeya8nzbcDvOKwlnc+A79ed5CuLpZuq5oBRMOEef8QbdK6UpHhOL0LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098705; c=relaxed/simple;
	bh=vOhkONJyWfbNZ+vuKycF4K3lBL5NoKgu121ldbo/HCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUAJAxjeqfSS53BBdHrSpfXeAW4nmorGxIEGBykQuzGN/WoHCfPLN4RUp4y//iR/Qi7Qr7XDIWRCosI7/yP2awvM17qWZxXQ0Z8PnS+7cKq+V7UhAduqXsSHXwywyGAFFu22l1k66eo0fTQ6/FacrPZC4d71uv4v0VbW7B1oHsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdDML3sc; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 3342940CF138
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 17:31:42 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MdDML3sc
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dP41WDgzFwdH
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 17:29:44 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 254E242732; Tue,  4 Mar 2025 17:29:42 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdDML3sc
X-Envelope-From: <linux-kernel+bounces-541111-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdDML3sc
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 1713A424E9
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:54:48 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id A926F2DCE5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:54:47 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B643B09CC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B61EE7D6;
	Mon,  3 Mar 2025 07:54:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960284C85;
	Mon,  3 Mar 2025 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740988471; cv=none; b=F6FHXBjHx10idc/bLm8G43f4xke1Y7ihy2u3vJDeSxWpNxT3JEKSPhzc0UcpdUHgNVoql2GL7g3eSwd04tMGH8u917BC355yICo6b05SewZ3+9b6gfAoGN8M8zSi03w9deRFnxqtNBcdq7SFjaQ/WAsulSesdznOURPNmE8IouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740988471; c=relaxed/simple;
	bh=vOhkONJyWfbNZ+vuKycF4K3lBL5NoKgu121ldbo/HCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nvk4KUNg+XwJ7iWFqDi12o3VPynF1EeY0JbLqa6krOv6/zUHqMXdiPdFi3z6SyASRDoEHIcLO1gt5ORdv393naU5JL5/pWV3EX5tqsAFFJYVfy4QpA6DabS2ySt66WWzIzlHcQtmuPvhPYK4KwI0uFZAYZSHFaRIu3fG9SiNztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdDML3sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7BDC4CED6;
	Mon,  3 Mar 2025 07:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740988471;
	bh=vOhkONJyWfbNZ+vuKycF4K3lBL5NoKgu121ldbo/HCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MdDML3scjcus143jtZmjir2fIgJ3pETQNcZ++JjwMMZYXCeKiq+vglTeALB4tGYJs
	 V1W9dlanwv4Iq1m4XXLJ8sSp2OoB715AeA56NrD2Wv34Ndt0kETDTkWdHwqAkHBkYo
	 cYM5zXbrJuEayjLmaycb+1APvgEuB8oeuFAO1TeLoHCFvS+GS42dUGJU6ppEwJwfze
	 QV0uau3EdL6d4zavkVXGXE5Ba84BxOG/UlJX7rtTHPyftP5ZDvI/Yn/yEuDUnnW9Cb
	 wPj6Q0jv7jW7R39Eg//NpVI9UGr9X66ISVj6uu9M8G+9ULBoqATCo8bxxLHKit6EVu
	 vLRkjOIqRKseg==
Message-ID: <fbd307ae-1dfa-497b-a597-d15b6baa30f4@kernel.org>
Date: Mon, 3 Mar 2025 08:54:25 +0100
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
 <CAPVz0n0ygR=ygsvG2+z-zST7kmJ_P3nxf29tqdgHpRs_Nw6D5Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAPVz0n0ygR=ygsvG2+z-zST7kmJ_P3nxf29tqdgHpRs_Nw6D5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dP41WDgzFwdH
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703410.06715@K9XJvIuA0Tpd592/qq9G0g
X-ITU-MailScanner-SpamCheck: not spam

On 27/02/2025 11:55, Svyatoslav Ryhel wrote:
>>> +

Please kindly trim the replies from unnecessary context. It makes it
much easier to find new content.

>>> +  maxim,usb-in-current-limit-microamp:
>>> +    description:
>>> +      USB Input current limit
>>> +    minimum: 100000
>>> +    default: 500000
>>> +    maximum: 1500000
>>> +
>>> +  maxim,ac-in-current-limit-microamp:
>>> +    description:
>>> +      AC Input current limit
>>> +    minimum: 100000
>>> +    default: 500000
>>> +    maximum: 1500000
>>
>> Half of these properties as well are not suitable and duplicate existing
>> sysfs interface.
>>
> 
> All these properties allow configure the charger to suit the device on
> which it is used. None of them are required but are a nice addition.
> Why you are denying me an ability to fully utilize hardware I have and
> tune it to the device? All those values represent hardware registers
> which can be customized for the device, not for the end user to mess
> with.

Because you put user-space choice or OS policy into the DT and DT is not
for that.

> 
>> And for remaining, still no battery.
>>
> 
> reference to power-supply IS included, hence the battery option is
> there as well.

I don't see it being used at all and you explicitly duplicated
properties which means that reference is redundant and should be dropped
with such binding. So how did you solve my request to add reference
which then you make redundant? Add reference and use it.

Best regards,
Krzysztof


