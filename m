Return-Path: <linux-pm+bounces-41957-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMeGCvXZgWlBLQMAu9opvQ
	(envelope-from <linux-pm+bounces-41957-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 12:20:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC650D82EB
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 12:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E1AE30C03AE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2C333438D;
	Tue,  3 Feb 2026 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR38R0no"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44B331A57
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117514; cv=pass; b=JfGNBeHWHtqid0SbnSdrhGRenx9pwaCldzrQnPSQjFQ+MsPuyzRLSo7QGzT1fBg3KR0K+5nSBR/C7BoKpO/GIdY6CeiU2MvNYMQm9t8lfxKsEfqDF3lWUZoqHAhwJypgc+bPvy+k4B0M6Gh+AVIf/gI86s20WNL4y02Yccp3D24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117514; c=relaxed/simple;
	bh=x0ozsReFvwxqdxxBW0bsucHLklQvL5qKhZ07z2jxlOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4MM7Q7WiqHnGZ++v5Bmw5e4qa8W5oOH13RN6tIe0pmH4IGG074sjQjcyJ+2PyB9dfVbqNHd2Q8u8XCWRNLie8b40S8gmTFx0nikF+vwnpO4tuyQ5O9YADzMjcEpgn9vmAEeOEu2fa4zf7vIy8YXZ9zqk8HU8t8da8wh2Nei0sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR38R0no; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so43362435e9.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 03:18:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770117511; cv=none;
        d=google.com; s=arc-20240605;
        b=ZzASkX1EkztPEucx6tB8525d+WBUGTSVbABhgLDaIfx/wyPATOkMuXDSqvZjn3qagI
         yI4SFoSer4okp2DW2mGswZoY8pZxRZYkLrDDSb6wu/mMOyOOUsvg09LaQmN42fQIZJ5p
         lYuysd0tacvFJ0f5fm03iEo7wsf3bL+AUgo+H3+9Vh0o1mRk89Us5nc0MvcgwoI/uYg5
         KUHriwcU7T5y2r74ETe+P2cjzulYDlzeSF1kYD98D9B8Sj6oUAbTRU+xSQ6dR0L0+fMh
         4O5AaeK9+sqDbir7ioK/y8NvWqB9IAhLex/A5RZdWspu8Ih1iRwcQDYmT3hrSCN5bNZN
         ujdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2zZNMGa3yn75FsqDEZyP0PuDAGN3sitzxX2byO47nv0=;
        fh=P7AMaHxsSZIJsLkmXa30JhiSRekZsO2grDRi27IM9TQ=;
        b=jrfAWAmOzmsvuJzapYMgcEHJJ1EQdRgT73x58xe2teztrADl1I6uPAu/8Ne8dVWYEH
         kqXWXDZFumSAGnV/IuFzScHgN91oEpFhn4KJNERoMJRVYVVIr8e9JFAQrDql512IJX/v
         eiMmjdkQNUFOsdg6xldbmy0BiglOfkd2WFgWvDPla9Wx0ErH5aQr/mgzBe/4rZvPHYTy
         y0XH9hnHgSlLD9JtCQSczQraSisOEiDT2fVdl4r7YpzbLvNhkgpobZPeH6JUqlXBI+hB
         XfdA0TJMDLI4FMuSG5+CY4E41grUsqsm8T26Z9WB3ArT+QuQSXuY8xc1D0thofr9aG+1
         O9nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770117511; x=1770722311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zZNMGa3yn75FsqDEZyP0PuDAGN3sitzxX2byO47nv0=;
        b=CR38R0nobPSER2TyZ4NQnKNQFmU8280WcWQeveL1FiVa1jy1p0hTfo/fYR0DxZ/Dfq
         227hwIzSY8zyulWXMhJy1ilRwNdo7bOkpfKGNk/jf/3ic05KANKYyYHfwB9IcTjbiiuj
         p40E0biNTgPNkBryF/S3zEG++0TdkAlUKTdEsZZqEt2n+25QgIMklWtnzoTFzIDCMAbj
         S5fGBmTP94HJCosPKdVubJOMDNkJ1BbUnF2GJNpihtI9H6m3O0rJyF76OV8B2pbWDukj
         n8b3/KXIhhf1WA2dpRpi4dW+LVGqaij7UIXvK0mKzU1cwJnFxljqrv+FgT00wXQwYIPJ
         9kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770117511; x=1770722311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2zZNMGa3yn75FsqDEZyP0PuDAGN3sitzxX2byO47nv0=;
        b=e5pV5dOx/oOz0w+hwf2DYSX/ODokIx4wKCi/+cYdLg2bbMK+g4HcWvreqSStBUpDLO
         RrtFC/r+djuzznsx7yyilbdCKkXtpVccDADkStNNJygzdVzIy/o+CVqHpxdKQo1N/EjU
         Usscj8LdEuvhisLF/S2APRGMDadKmv3/v6YuLyL/uvQNMnfsdMfaBtM0Jw3/fVKNdZwU
         xNfZmYp+iiL2gSqAIWmPISB7iVb54kKSruDpVcHs3dYNMTKiYlMGXlxAe8+Rfr8xgdt3
         XaUAQ1/rnDoQjEO7PW0xKvJym3TLx/Cf6icwcRMPGEijnjZ2sQFtvoByko3sxeyMkPPf
         vIRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfe3gK1oS/Vzd0uiGzM5m5rOtlf2iJY/zX6/oInn9f6jL7s3ZDHE5RsPElUdjVPZq2dxUkKgm9RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLACs+Ys6QXiyJcmIcV35nZBoEuGyKRgYp0pfpvWE4+lLBNExo
	tGCVn/r8VLXRjox8b7kgGxFseehHKkUjpUiTQQagAxijMPLHG6ZCbO1kfrUSUyPjcyRSmMTA/z2
	13Zl5GW7ga6twg63f8PGTKxCKjNe+y7c=
X-Gm-Gg: AZuq6aKMYagpnuUDFNyL2Hy6CgHevMprrKaQM/QyPDLSZ/kAZtfNYlpvUaFAMfUfL90
	L5nr4ipQOJU8y51RzrarbvoHN6QAus6sDQOFdUUJM+3+ztytmzG5QmIaOiQXI+edhV5pu2+Mmy6
	ZQk6STEvN6gXQ4FqoeqGEgTDsHLKostXHlJFtoNGjMyFx/tZ+2GRFMTEMEaZ3r5TbBG3gOAqw3D
	3vq/njOU9gtWip1e4UtAtK7U/Bq1dKOMCl1I8V6jRJIdk4ZwuT5BFzQwVqdC92gZ4M4IhH1
X-Received: by 2002:a05:600c:1c06:b0:480:6bef:63a0 with SMTP id
 5b1f17b1804b1-482db4d859amr196633815e9.21.1770117510819; Tue, 03 Feb 2026
 03:18:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201104343.79231-1-clamor95@gmail.com> <20260201104343.79231-7-clamor95@gmail.com>
 <aYHU5g5iOVjrHrE_@google.com>
In-Reply-To: <aYHU5g5iOVjrHrE_@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Feb 2026 13:18:19 +0200
X-Gm-Features: AZwV_QheFCGeHv9dTwRKbCZ3hfG3HmOrfJbSWa64fyut6TH7i-1Px0zxlCCElGo
Message-ID: <CAPVz0n0YXJ2KdO2LPJ8gYr_8=TuaEnY+=sVy1AsiiNtJG=nx3w@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] input: keyboard: Add driver for Asus Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41957-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC650D82EB
X-Rspamd-Action: no action

=D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:00 Dmitr=
y Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Sun, Feb 01, 2026 at 12:43:40PM +0200, Svyatoslav Ryhel wrote:
> > +static void asus_ec_input_event(struct input_handle *handle,
> > +                             unsigned int event_type,
> > +                             unsigned int event_code, int value)
> > +{
> > +     struct asus_ec_keys_data *priv =3D handle->handler->private;
> > +
> > +     /* Store special key state */
> > +     if (event_type =3D=3D EV_KEY && event_code =3D=3D KEY_RIGHTALT)
> > +             priv->special_key_pressed =3D !!value;
>
> Is this functionality supposed to be triggered by any keyboard or only
> the dock one?
>

Any keyboard. Dock keyboard is basically a regular keyboard fused with
a multimedia top row.

> Thanks.
>
> --
> Dmitry

