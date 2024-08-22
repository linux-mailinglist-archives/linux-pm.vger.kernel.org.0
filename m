Return-Path: <linux-pm+bounces-12707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763D195B007
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 10:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1AA2B223A0
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 08:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4B6157A43;
	Thu, 22 Aug 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM1f98vz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB7A13C3DD;
	Thu, 22 Aug 2024 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314668; cv=none; b=CF/ZQ/Sge0XGNW9Y3htWQklqjGvm2Xrm4HPEijskep3FD4QLYCxRToUwAJfjRlbYsjW0uGkOUiMjyv2mBRsscHYkSoOmCRSaLu3DsME40BFFpSyGXnO2kXaAGf5UueKP7r4qMWnmiR/MAVj6WEYz6kV79kEnyKO65zE0Czl7nAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314668; c=relaxed/simple;
	bh=i9+RZMgNXDfIKM6AWUP3aKBMFAEeLFnrjodDLj6ekIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAi1hyDR1uGPgvHhnDiyw4ZmVY9O0obI9YcUZewR1+LUerUbr5RmbJQKGw05PQOZsdgIkSkYyLnMB1GCsXfdPb2/KYforcZzVrpfisr7ilta8gHeieLdBpZy3iy3PKtEeKWhsltr+ohfZV85BASQrB00UiZfXNtKQfV2Fym6omY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aM1f98vz; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f43de7ad5eso435751fa.1;
        Thu, 22 Aug 2024 01:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724314664; x=1724919464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPKMD2ynTcsQDN/WlLeg4f9d/2wCVzNZpD/3xY7a2os=;
        b=aM1f98vzfiOdyw2ly6CMyUAqEb9ljDHAKmsUcX6FEOadBGuTw4f4CmAC0o+YlkEHlX
         6AhXbAhf0zih7b+2LjYLFKeVwexeBJ38yK3ger3LQLb8Am1n8PLkIVHqKzR/V7CuoXjL
         BDTBn11IKVO/GqQH0HuvFWY2SD/44aW/IpbzqZWUrbmP7TCYTGxceoAJYfTZb/nOdJ54
         uVTP46CRvmv0WOGfKwdEL3Gv33xnCWIbJEhsSkDqRkg4nxXXahMVsHKt0heK/VftO8Ak
         3+U2yz3lsy588qBLdy67LViuSidL/8RmLzukVrw565MpuZPkbJsPm2ayioXGBfWFGRUB
         TYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724314664; x=1724919464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPKMD2ynTcsQDN/WlLeg4f9d/2wCVzNZpD/3xY7a2os=;
        b=Lir5iTwNJeeaNf60Pm6t+EPUamMyi6LU4wXAvgeqrBiqRRcEkjGyscFndjNgB3pJdU
         OrgtXB8PsP9/8peECxyqrp+X4iA0+yC5h9nu37l/V4m9IaQXafcciKvthI3jvg76+q2c
         IPFlF9pwGJt155eN1gX9ELN8aRT3BngcoTPjiwZXNNocqV0IN+GjND55FBMoqWwVe/qn
         F4hwxpa8+6DGBS/xMEleo2ntHARuDkr0NeL16OpACEuU/Qioz54pVjjxVlk0PouUD6NK
         A6YwUjmM/EKQ8/SQ22U/Lm41PoLHoew5S9zrcBEZG8Kl5pJNYIyJQZ9UcnyVspCPOfXm
         rs8A==
X-Forwarded-Encrypted: i=1; AJvYcCVKJxKQvV+qlfsmmdq5z0fQA2V3Co016UGbCNqjxtOhnuFypCb2KTc693MuvjwggjrRUjgpmK5UtI4v298=@vger.kernel.org, AJvYcCVWJ3Af5CCSDTgnks4oXRMBmAs8UnkboDmKWVmjGj/IpEA7AumvKEnxUXPieOKInoPj4ZjQMaqtAZg=@vger.kernel.org, AJvYcCXWDkc9/YTg16dYceO35wn+Ddk3CWumdVBmQ2kCsFS8CYq3aoGI/yKwJwlqu4vC8HbZMF9gpevD/vlo@vger.kernel.org
X-Gm-Message-State: AOJu0YwH18lYgcrDZEk9pI4mi/wwqhb96h2IAmMit2CqUvhKCa5Z/Dgo
	gBFWDEGUTe8aH3fZdfN1nysxb3YBjQyiF1yFuzsmxkApzX+pXe8aLrhGtLs2lTUDyPiydtZw87K
	+6gkCQ9In5abOTOnSNpK9Fw4wKwyaSANsbXnS1A==
X-Google-Smtp-Source: AGHT+IFFMGVRKgodSsQZ7JSSR15ua0Tg42BukRvBOfUO2Xk2QpPePWxJVVeKAvvMzHma4Pa7V0RNd2iezTpeFWy8aJY=
X-Received: by 2002:a2e:b5c2:0:b0:2ef:2061:8bf5 with SMTP id
 38308e7fff4ca-2f3f8b56c39mr24729761fa.40.1724314663665; Thu, 22 Aug 2024
 01:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38b871f7-8583-4b9a-940b-ee33a1b6206d@molgen.mpg.de>
 <2024082207-foothill-swirl-0ad0@gregkh> <8092403e-cc8a-45ce-982a-c954e7428c32@molgen.mpg.de>
In-Reply-To: <8092403e-cc8a-45ce-982a-c954e7428c32@molgen.mpg.de>
From: Rajaram R <rajaram.officemail@gmail.com>
Date: Thu, 22 Aug 2024 13:47:31 +0530
Message-ID: <CAOiXhaKr9jctG0qUg3zqitUo7ZCTq9CB6Huc1NO5B2ArjCGjBQ@mail.gmail.com>
Subject: Re: USB-C adapter like Dell DA300 using > 5 W
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mathias Nyman <mathias.nyman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 12:36=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Greg,
>
>
> Thank you for your quick response.
>
> Am 22.08.24 um 01:31 schrieb Greg KH:
> > On Wed, Aug 21, 2024 at 11:32:04PM +0200, Paul Menzel wrote:
>
> >> On the Intel Kaby Lake laptop Dell XPS 13 9360 with Debian sid/unstabl=
e and
> >> *powertop* 2.15-3, connecting a USB-C adapter like Dell DA300 or LMP U=
SB-C
> >> The heat of the USB-C adapter might suggest, that it draws that much p=
ower.
> >> What is your experience? Can you suggest something?
> >
> > Buy a different adapter?  That seems like something is really wrong wit=
h
> > it.  Does other devices also suck that much power from that port on the
> > laptop?
>
> It happens with two Dell DA300 adapters and two LMP USB-C mini Dock (P/N
> 15954, 12-22 Rev. 3):

 Is this behaviour only when the ethernet is active ? Could you please
share the behaviour with no ethernet connection ?

