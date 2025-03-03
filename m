Return-Path: <linux-pm+bounces-23377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D908A4E2D7
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6A23B6C67
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6849B265637;
	Tue,  4 Mar 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdDhTQiw"
X-Original-To: linux-pm@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D421925FA2C
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100395; cv=pass; b=MAN9Za6RtHQJteYQ4toWXWH6s35NjOjQ8k87H1i4kq8DKTnGXkn2CEHlX3q9SPx6YT05yghrFYC5TnXjSUDMTxIo217e/FlB229M/JMCJJJ9fXyqLEIgzla/wFRrA8GcvSt6BxYma32LeqXCV4CN7PxhejQEKMIGoJRKCXBH6m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100395; c=relaxed/simple;
	bh=zlZxtHRu5ehzldwLK+ya5zBWIS/wU4//85x3BEtkIbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bI5aapSK/kkGEqHOrBjJWLtsM/aSVbSOmnyTaclvCjAqPuIv+0HnZ+f8QQ7KxiEeumn1GRrwfnVWrITxHy7XsY/D0DTmguEQqGJKB5OAzRJJ253RgczFfd/Kql5BRd0y5gcdCz/WiFp/kykVGdDpdyLv6q1qaxdpZJxNbYfG5cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdDhTQiw; arc=none smtp.client-ip=209.85.221.45; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 104C240F1CE0
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 17:59:52 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bdDhTQiw
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6f1Q6cNdzFxpD
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 17:57:46 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 7A38B4274B; Tue,  4 Mar 2025 17:57:34 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdDhTQiw
X-Envelope-From: <linux-kernel+bounces-541122-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdDhTQiw
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 434CC425D1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:11:55 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id D4A682DCEC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:11:54 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FEA3B0426
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F91EEA49;
	Mon,  3 Mar 2025 08:11:42 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183D13A3F7;
	Mon,  3 Mar 2025 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989499; cv=none; b=OP6yFFZ+2Mf0mmCElmm/sg/zP/FpnNevyj2ii/xPUW5YZXKMzM1BlPXOrtTffWfLCM5eGZiBd6GXu2LcersdObrHjCYY/163l26d+MdUt6psxJjNlGjWD+kjHnsfrUWyrQ/R8pM/SWfqF7i8WadPYW4umIVzZO2ll5Q36No2Vx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989499; c=relaxed/simple;
	bh=zlZxtHRu5ehzldwLK+ya5zBWIS/wU4//85x3BEtkIbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRykvujfcRBSe74FWQ4hGfB+vUnO4+M/pz93kZxTV/4DS1+ErLPfwCnHDev9VjVROBbQ+84zK0FJa1PQKWvW1lKB3HZ/2FDFWCq+SUt/3B7VjABFepb6gsIpu6b4fTEmrFGVkvDw2VNGqJmTkGMUbvTqWt8+U0Dv11uARfXSO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdDhTQiw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so2390729f8f.2;
        Mon, 03 Mar 2025 00:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740989496; x=1741594296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z6L/MI7GjiBeau82X34Q0GZ550CnqYRZsnAOUnmcj4=;
        b=bdDhTQiwiBg3q00cxaeK6asZRDv2VBYyx7m1hLaUqqsZDR/F1qMWirMGM6/OKFH+BI
         ZznqBdCXbvwsUk6PNek4trjbuPl38j+vLlBjS9ZEnpVGH4ICgAu6HXNRz+IklxDep6V4
         ePzh/Mmb0UOWtzujmtslrYp8M3dFJhF1XjDowMpjfJg7blWDkqebWV51VTFt0Q9bh5Jy
         YTq+Ygfs1ZpFEafPuRWmldCZnDVMWTGbrsL93Vf6KTpXIf71GUt7Vh4x6wSIrbXEpWUo
         dgbrNKffcmKKHyQhSEihgyBruw0m6x+kodSXFghdpjgUT6gJCj1ueVF3KY+LBePhckyt
         2qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740989496; x=1741594296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z6L/MI7GjiBeau82X34Q0GZ550CnqYRZsnAOUnmcj4=;
        b=BkLVKVznKDGrxi4bC0I8VRUZaQuAyZrFqkcNt7aCZOH1c+fDWV9s3pNC5nPBxp6z1M
         6feX6EAAjRDlPVAzef8W5FhPaZw8g3X8Q8+GCTVe/M4md6EsCJrTnSXh/DABI/xApHN+
         xh1fpYP0Nh417No1HswE6AzZvXV/rlEsdO4lqhxgwOZRXrV9C4JtzOZ3RjJGJGqf2W5J
         6xGfFKrpw8/ZLXYy8sYuGvZyb/YXIZ8cB53bYMQpIOqlZ+dD3dDq7hiBzERfbjsGcpv/
         Z1clOlzzAZLJSYHksUpCwH+p3fZrT1oqTrC37Bh97X7M1QQqFXyV/za6nAdnyHWvQwSX
         v+6w==
X-Forwarded-Encrypted: i=1; AJvYcCUSsZ3cpPV8wRLKSJaahkwmXa2ryzHPGUt8MOdo/stJrmfjEx0qjuYIQxYr8KNJdZAvaJtzDCYnIFZnA4xS@vger.kernel.org, AJvYcCUXLeJOBryZSYY+I+Lpf+gwkrTUgigLuT7xqIbCNdAiX9lThUrgyA44+M+fq9msY9GTohU3rtR2ZYU=@vger.kernel.org, AJvYcCWTBalb7c9O9D60I/WJeA/XH4KxuUFIVJ56Ub8c5SASs1AxTLRRQaPBvO3Hi841fJAinKGG40MWAvP9@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0a7L6RUcqeN7fIc9CbNREV4uDWM/c9//kLUJnI9w3TJysm3e
	OWhqkB+BzFHg/jdS7OgOgel30TMLg4i7hZeYf+5UnlbrQf96cwuLCGoITRiu6krWSNDnu0QY7zi
	/zjuYwTZlB6tO5wA1inAGx2xvdxuF8II8
X-Gm-Gg: ASbGncuazgm6fRto6nQpyT9hw3k1c2Fi3bjAa1S7TITUmUjTmPG1yZ+GRlxILHQRwnK
	6Is+CYMqSDVNBoeBTxfrlhUK0bzj9QaFF+UEpodPyzBc+8uETSGLhV9cC0SSJHp2AubvibJmfET
	oGzifrryLHr9G3rqlKdc9gJ7tSmR8=
X-Google-Smtp-Source: AGHT+IGRLxKuQltzk3e4B+3XcQJpDonfFrlVdMJszjPJ8OA7ttLmcIax9Y8G7xZMscwBZ1g5e59TEwWWWUyrUN4P1E4=
X-Received: by 2002:a05:6000:1aca:b0:391:10f9:f3aa with SMTP id
 ffacd0b85a97d-39110f9f4ccmr650449f8f.9.1740989494135; Mon, 03 Mar 2025
 00:11:34 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226093700.44726-1-clamor95@gmail.com> <20250226093700.44726-2-clamor95@gmail.com>
 <20250227-cherubic-mantis-from-betelgeuse-86f5ff@krzk-bin>
 <CAPVz0n0ygR=ygsvG2+z-zST7kmJ_P3nxf29tqdgHpRs_Nw6D5Q@mail.gmail.com> <fbd307ae-1dfa-497b-a597-d15b6baa30f4@kernel.org>
In-Reply-To: <fbd307ae-1dfa-497b-a597-d15b6baa30f4@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 3 Mar 2025 10:11:21 +0200
X-Gm-Features: AQ5f1JpF_3CGGZHse1vw-xjEiqhgLaEu4i7B8BPiRRXnSBWrzMGYDYQBdUdMgQ8
Message-ID: <CAPVz0n2no1EJnf4GKSJWfYA_8h8x6BRk_ducufie90YPZR-k3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6f1Q6cNdzFxpD
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741705080.97204@BVrcg1uIsFF5SZrTMDkPrw
X-ITU-MailScanner-SpamCheck: not spam

=D0=BF=D0=BD, 3 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 09:54 Krzys=
ztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 27/02/2025 11:55, Svyatoslav Ryhel wrote:
> >>> +
>
> Please kindly trim the replies from unnecessary context. It makes it
> much easier to find new content.
>
> >>> +  maxim,usb-in-current-limit-microamp:
> >>> +    description:
> >>> +      USB Input current limit
> >>> +    minimum: 100000
> >>> +    default: 500000
> >>> +    maximum: 1500000
> >>> +
> >>> +  maxim,ac-in-current-limit-microamp:
> >>> +    description:
> >>> +      AC Input current limit
> >>> +    minimum: 100000
> >>> +    default: 500000
> >>> +    maximum: 1500000
> >>
> >> Half of these properties as well are not suitable and duplicate existi=
ng
> >> sysfs interface.
> >>
> >
> > All these properties allow configure the charger to suit the device on
> > which it is used. None of them are required but are a nice addition.
> > Why you are denying me an ability to fully utilize hardware I have and
> > tune it to the device? All those values represent hardware registers
> > which can be customized for the device, not for the end user to mess
> > with.
>
> Because you put user-space choice or OS policy into the DT and DT is not
> for that.
>

Those are NOT user-space choice or OS policy those are vendor
configuration for a specific device and are NOT and NEVER were exposed
to user configurations EVER. User messing with those may lead to
device breaking.

> >
> >> And for remaining, still no battery.
> >>
> >
> > reference to power-supply IS included, hence the battery option is
> > there as well.
>
> I don't see it being used at all and you explicitly duplicated
> properties which means that reference is redundant and should be dropped
> with such binding. So how did you solve my request to add reference
> which then you make redundant? Add reference and use it.
>

Which properties I have duplicated?

> Best regards,
> Krzysztof


