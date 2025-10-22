Return-Path: <linux-pm+bounces-36641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC23EBFB7A6
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 12:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405C619A2946
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DAF3254A4;
	Wed, 22 Oct 2025 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvK2+WOc"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483473233EA
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130455; cv=none; b=EdrNQUsEJAqiNi3chh3+AI+yD+SCoPTDeES40KcTZnwlikzqfXHDmzeYp0/2KG3B6sS2FNaD2W5+En0v6sFhQBPpaLXsrzBuNfzTVUoCy/2y9p6Saz3Act/lECOTxN7XdXkHZJWWvfHyTfXhOlgWXxBGqlB6qbY/sIl4WNwAPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130455; c=relaxed/simple;
	bh=yAme9gZz0jsPec+TiumN1DBQ0+B9qNdo1HlM5nTPaxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bfy4BjRikKTHvjpoaR//SBvDEwUcdfJI7qcnwY/ug1KeLGBO1aqXMLdCHN7DEcF2iHE3LAJ4XsBXTLvlkhW6aztah/nJRQc410k5iotxIR6yyIz4OaEt0MLDU2lpI247UCKDaujKtWaqY7Yc8vidNnRjk2I/h6/tulmapH/zdtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvK2+WOc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761130453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAme9gZz0jsPec+TiumN1DBQ0+B9qNdo1HlM5nTPaxM=;
	b=DvK2+WOcsvBH3W+uPssJvwJqnahdFI8dnJym0MBVAL5na9ZZs5lgfSyJX126eGPbnoIoEI
	Z1HLmz170l9DiQ6iyEwdHibdHaVEKVVppSpzOsoBDKxdTDNZrvlcux44g25X4jVX+ony5g
	T3uOgOBg+3H7sABud0Wj+9ZZHpffGJU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-peuuI_6oPp-Pr6eCf3yDYw-1; Wed, 22 Oct 2025 06:54:11 -0400
X-MC-Unique: peuuI_6oPp-Pr6eCf3yDYw-1
X-Mimecast-MFC-AGG-ID: peuuI_6oPp-Pr6eCf3yDYw_1761130451
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-63c55116bdfso4948302a12.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 03:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130450; x=1761735250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAme9gZz0jsPec+TiumN1DBQ0+B9qNdo1HlM5nTPaxM=;
        b=bN9rcMzTM4WYNYYKTNL7whR/03T/mx+V5lmPk2JyZCw+y2+ILAXNk3VEBZpbdaZDT+
         HPM1b4yG7NRrRcGSHbJA3lIPAoHgZ1TGA5+HcvzmvmsBmL//UPqWyYFMr3w/t7NbiY5M
         o0mbEJoUg/h7tryvpnTR3t98FkZnh71/URFiiJEkR9j9YVwvW8MuYKsUzvDiFu+c0nkn
         LNV/vwlhyxhcaS3pAKrIWAjv0GaWw9E05EOSDKfqmvNArE03GW0p7bRSbVRomX9q60Wy
         lJWYVFMXTPM0PP2YHilUJts5p8zH6L1VIIrjV1cbwKQT5YGmY7sZNbnHzKrbKleoWrkT
         6KkA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3qNtOA1XoNlJzEpj/RRic7/ZZLWaGpaTdhw2x427QMr1+ii+pXyaa2lr2tBXjoTeB7OevM3IPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB8TBCR9uXtlhWnGkDSNHtc0orbFwRd9W663WMKs+YmNqQ43HI
	/S58RsOdvkXzdYwKE5FXHhm2RuB/ONitxrxa1kJ6GRr5QieMOHRxgAl0lzMc1T+Hl88YCIeluRX
	YL/YMSq5LUX1EMyltXdQ8uSJzRsFKRaZB1JQorWqkE9+zxaA0gu9zVXsFn+xvRpBnGf+WgNEmIb
	sBo158cpS8h06eu71DdQw4joZbP2dbsGlsefQ=
X-Gm-Gg: ASbGncvmCVQJ11P8Oz0Ln8BLmJdEwMXAraXnsnqXS9e5Y6c5AYAoQ67wkBd3Y2EDop5
	WAg3ryAnTAJTI7ZsTycnqPgevN0bK6TrtMExOjxOpz0vc9zP7lTZG1ZYEtvDKwMv4Ts2J4akYm/
	jPRn8oExfL6HKTshCH+MtEEYA1i/s3fx59VjRQYu/v5CAw0iNjlCXV6fKhFQ==
X-Received: by 2002:a05:6402:3554:b0:63c:4d42:993d with SMTP id 4fb4d7f45d1cf-63c4d429b92mr14924957a12.31.1761130450615;
        Wed, 22 Oct 2025 03:54:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwXo2Nnikbm4tEQdmgmkZp9TZORUaZ7NSsb6jc2EYon1wJHlulaxXg07EbqzbJhz2+0tqMwSZX80MVwHLznqQ=
X-Received: by 2002:a05:6402:3554:b0:63c:4d42:993d with SMTP id
 4fb4d7f45d1cf-63c4d429b92mr14924933a12.31.1761130450205; Wed, 22 Oct 2025
 03:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013193028.89570-1-mrout@redhat.com> <20251014053608.pwlnexeh7mwjrvsc@lcpd911>
 <fdac8d84f266ba85d517542bdad0592bdc33b95d.camel@redhat.com> <CAJZ5v0iLCcCpiBqgQM=GcEAnQvZxgbtMy+bWGrWDQEikYOgC=Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0iLCcCpiBqgQM=GcEAnQvZxgbtMy+bWGrWDQEikYOgC=Q@mail.gmail.com>
From: Malaya Kumar Rout <mrout@redhat.com>
Date: Wed, 22 Oct 2025 16:23:58 +0530
X-Gm-Features: AS18NWDcKkqLf4WGgRCf3VkZNzrXzmQMf2fm-cuEeYgk3yjR7d7XbHLUsCk1kdU
Message-ID: <CADD9qegh88p3gBWbAhV02ScWR7GOc9Tby6QQouLFAzN7ceozDw@mail.gmail.com>
Subject: Re: [PATCH] PM: console: Fix memory allocation error handling in pm_vt_switch_required()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org, 
	malayarout91@gmail.com, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 6:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Oct 14, 2025 at 6:54=E2=80=AFPM Lyude Paul <lyude@redhat.com> wro=
te:
> >
> > On Tue, 2025-10-14 at 11:06 +0530, Dhruva Gole wrote:
> > > Btw you can't include a R-by tag in the very first revision of the
> > > patch. This needs to come from Lyude on a public mailing list and onl=
y
> > > then can it be picked up.
> >
> > JFYI - I don't know how consistent this is across subsystems. I do usua=
lly
> > post my R-bys on mailing lists, but it's not unheard of/unusual for fol=
ks to
> > pass R-bs through means other then mailing lists (like IRC).
>
> IMV, they should be on a public record.
>
> > Regardless, happy to post it again:
> >
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
>
> Patch applied as 6.19 material, thanks!
>
Thanks for applying, much appreciated!


