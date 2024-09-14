Return-Path: <linux-pm+bounces-14213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A648978CCF
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 04:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935F11F23630
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 02:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C68C2C6;
	Sat, 14 Sep 2024 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN3Yc/P9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BE7749A;
	Sat, 14 Sep 2024 02:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726281803; cv=none; b=ebM0F0B731dr2tpc969d1mDC4X4qnjfr0YH0gs1r3MoajTUva6XAoaOf0fjzPR9pJN1HqVxnvi2qKRyM1EEA4yjqRlWjZJE0wciaCCQXzVQyDgbXju/x6Cke45iXJYc3xlgFzo8xIo9aLHhfRjdY7sR/VkLrgA3K30Fin+mESok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726281803; c=relaxed/simple;
	bh=tjRyGoaljETd7XXcvzkGVz9KB2IwkpLlxWV5yB8uCs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlz+QO9rnEVVbPwI3cS5RigKE5lVOPr+iAUke/SOC6rdiB5n/JAkKplDs0U/UPTJD7VLWn86j9V7Zschl5fuLfYn4uCxr/++DrzAvJ33C77ILSMNFC9/CePVLu9uqQEUjlztEpFrHIxKhSmTgjKcgJ4gkW8/Z/cDUmeQoC0k94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JN3Yc/P9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-207397d1000so29834585ad.0;
        Fri, 13 Sep 2024 19:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726281801; x=1726886601; darn=vger.kernel.org;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mubNyPnb8zSnh/nOnw85megp6C2bh9UlksX6pt7nV3I=;
        b=JN3Yc/P9AnBw8J9/7dKd95MHRHOW/5MQhWyMRwLWg50caijMxg6M+h9n9QnHLb9oQZ
         4lJGeiF1DlxrOihGwrRxawONp11eisemhDEXNpoogppInsGzmb9zkGVYF+J4299LZ9ox
         fkI9p6fDi45zo4skx9wfnPZpDNPDMwXPcRk8J2miexSYJsZC8HGiraEaQdxdsv5B0yCl
         7QsIi0INx5l7ybLmamhlIPX1RWeThQZ22/NrTOCN1+TDUcN8CK8dBlzXNynKjDzYA1wb
         vv2RaGKTqUBPqNiZz7zWQ9wAFtaoQdyqqBwWc+ruHoYAaR/nCbH52zoBQVaKaOgDC32a
         sa3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726281801; x=1726886601;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mubNyPnb8zSnh/nOnw85megp6C2bh9UlksX6pt7nV3I=;
        b=r3Orwsjnx1smBehUcFBCWU3gCu8LHqVWHGLsYGkL13SJdG/RqphDFQvP17EdyNaL5u
         rKQYLS0kk/0Y3m0N2+efhgrtl49UYxkx63BjCXU6+1EV8t7wBQHMuagz7y2+PgdzV8F7
         0nEWl7tGJKlYOohptWvRix+X7ULTa+BZfyNJ7dcfMYrdoxQVkRxORuLeu6IOg7GCjRo1
         D/6jpyaHxXKYr/U3m7x2bhqN88nYfOu7Fqnam4azBEXvtnwgnPfoL4punN1KXbMWUrMH
         qj1Tzf1FmLp3pZ6b0+DZXszTcu+UMjM44FlTguu4YkkdmfDgz1wHIo/h7OzULqS34/PM
         usDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBeHRN6FiS8Q6/nqwrl9iiOT7/vB14cfB8DXx82ZmA8mNNUdozaNNEeVuOy71k14rWW0Bnwp9gpGDMZa0=@vger.kernel.org, AJvYcCVEEYYRdg7Qlp/VzNciH2oxM8xnHaON0xOYsn58PH5xEgfE+XN3pnmCZQYm2XlijxhRvf/FHYjwpwOp@vger.kernel.org, AJvYcCWgmFq9kfsLi9J4ZDx5VIvPsb5BtQmb4hLlHfW6ibMw6Sr8BJ0W1fYnsjJGdKm8EU3a63YBp7abFhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbUrNKNltg97pTfWbBryFtefZv/2183ZbcI508aLNU1wlMLOj
	hwhoZEWa4HsYltdjHJ022Ia0iJP+LgQyOf/NxC5FUmDRYFmwDS03
X-Google-Smtp-Source: AGHT+IF+c+p16cCyt4scuDIl4aQvc1148/NrTvLPzWcCRskLLrH1hxr8ffmeIcSWmOu+j+CRHKah/w==
X-Received: by 2002:a17:90a:e183:b0:2d8:e6d8:14c8 with SMTP id 98e67ed59e1d1-2db9fcb9e8bmr13159625a91.15.1726281801145;
        Fri, 13 Sep 2024 19:43:21 -0700 (PDT)
Received: from js-pc.. ([2408:8453:20:6424:f77:48cf:37f1:1e10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfcf58b6sm403615a91.13.2024.09.13.19.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 19:43:20 -0700 (PDT)
From: Hongyu Xie <xy521521@gmail.com>
To: stern@rowland.harvard.edu,
	duanchenghao <duanchenghao@kylinos.cn>
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	niko.mauno@vaisala.com,
	pavel@ucw.cz,
	stanley_chang@realtek.com,
	tj@kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by USB
 status when S4 wakes up
Date: Sat, 14 Sep 2024 10:43:12 +0800
Message-ID: <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
References: <20240906030548.845115-1-duanchenghao@kylinos.cn>
 <1725931490447646.3.seg@mailgw.kylinos.cn>
 <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
 <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
 <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
 <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc: imap://xiehongyu1%40kylinos.cn@imap.kylinos.cn/Sent
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

From: Hongyu Xie <xiehongyu1@kylinos.cn>=0D

=0D
Hi Alan,=0D
On 2024/9/12 23:00, Alan Stern wrote:=0D
> On Thu, Sep 12, 2024 at 11:21:26AM +0800, duanchenghao wrote:=0D
>> =E5=9C=A8 2024-09-11=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 10:40 -0400=EF=
=BC=8CAlan Stern=E5=86=99=E9=81=93=EF=BC=9A=0D
>>> On Tue, Sep 10, 2024 at 05:36:56PM +0800, duanchenghao wrote:=0D
>>>> S4 wakeup restores the image that was saved before the system=0D
>>>> entered=0D
>>>> the S4 sleep state.=0D
>>>>=0D
>>>>  =C2=A0=C2=A0=C2=A0 S4 waking up from hibernation=0D
>>>>  =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
>>>>  =C2=A0=C2=A0=C2=A0 kernel initialization=0D
>>>>  =C2=A0=C2=A0=C2=A0 |=0D
>>>>  =C2=A0=C2=A0=C2=A0 v=0D
>>>>  =C2=A0=C2=A0=C2=A0 freeze user task and kernel thread=0D
>>>>  =C2=A0=C2=A0=C2=A0 |=0D
>>>>  =C2=A0=C2=A0=C2=A0 v=0D
>>>>  =C2=A0=C2=A0=C2=A0 load saved image=0D
>>>>  =C2=A0=C2=A0=C2=A0 |=0D
>>>>  =C2=A0=C2=A0=C2=A0 v=0D
>>>>  =C2=A0=C2=A0=C2=A0 freeze the peripheral device and controller=0D
>>>>  =C2=A0=C2=A0=C2=A0 (Check the HCD_FLAG_WAKEUP_ PENDING flag of the US=
B. If it is=0D
>>>> set,=0D
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 return to EBUSY and do not perform the follo=
wing restore=0D
>>>> image.)=0D
>>>=0D
>>> Why is the flag set at this point?=C2=A0 It should not be; the device a=
nd=0D
>>> controller should have been frozen with wakeup disabled.=0D
>>>=0D
>> This is check point, not set point.=0D
> =0D
> Yes, I know that.  But when the flag was checked, why did the code find=0D
> that it was set?  The flag should have been clear.=0D
Maybe duanchenghao means this,=0D
freeze_kernel_threads=0D
load_image_and_restore=0D
   suspend roothub=0D
                                      interrupt occurred=0D
                                        usb_hcd_resume_root_hub=0D
                                          set HCD_FLAG_WAKEUP_PENDING=0D
                                          queue_work // freezed=0D
   suspend pci=0D
     return -EBUSY  because HCD_FLAG_WAKEUP_PENDING=0D
=0D
So s4 resume failed.=0D
> =0D
>>> Is your problem related to the one discussed in this email thread?=0D
>>>=0D
>>> https://lore.kernel.org/linux-usb/d8600868-6e4b-45ab-b328-852b6ac8ecb5@=
rowland.harvard.edu/=0D
>>>=0D
>>> Would the suggestion I made there -- i.e., have the xhci-hcd=0D
>>> interrupt handler skip calling usb_hcd_resume_root_hub() if the root=0D
>>> hub=0D
>>> was suspended with wakeup =3D 0 -- fix your problem?=0D
>>=0D
>> Skipping usb_hcd_resume_root_hub() should generally be possible, but=0D
>> it's important to ensure that normal remote wakeup functionality is not=
=0D
>> compromised. Is it HUB_SUSPEND that the hub you are referring to is in=0D
>> a suspended state?=0D
> =0D
> I don't understand this question.  hub_quiesce() gets called with=0D
> HUB_SUSPEND when the hub enters a suspended state.=0D
> =0D
> You are correct about the need for normal remote wakeup to work=0D
> properly.  The interrupt handler should skip calling=0D
> usb_hcd_resume_root_hub() for port connect or disconnect changes and for=
=0D
> port overcurrent changes (when the root hub is suspended with wakeup =3D=
=0D
> 0).  But it should _not_ skip calling usb_hcd_resume_root_hub() for port=
=0D
> resume events.=0D
> =0D
> Alan Stern=0D
> =0D
=0D
Hongyu Xie=0D

