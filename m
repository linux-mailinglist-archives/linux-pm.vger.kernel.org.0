Return-Path: <linux-pm+bounces-21961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F74A32628
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 13:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B09C3A89FA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584131F866A;
	Wed, 12 Feb 2025 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGGi62R6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837120E00E;
	Wed, 12 Feb 2025 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364426; cv=none; b=t4Zt0nxR2XvW6URXrh6DnWHGLrYpH5OlrfnjmZIlS6cF5sOMp3cwjenFy0S2U2gZxQ8BgaJo26bWItXuQUGvR6/SiYHPr4OmNKGGEW7b+I+H/rKSIU/cKWoOxbCIy4Hq7wYcIIPHuD8JS0Z26b1mKz6FmoW/TgMdI9c/9Aa0bsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364426; c=relaxed/simple;
	bh=tY5gwz0K1pH9LPERb3scr9O6bcGKY6gXL50Bkc8UiRQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cs4Q7SdWKidilHr7thOlYW3U0zBRsqsj6FBqolU1tW3/3qxuqZIWz68pLrbHi34iuHj/xZQL4loY/y81JVQIGZYnD5znTMDw+kSTiK3NFKuqKjozDSWTOB1uBCIH1lmYrxvgnUyHhgt9I9HvD+UqZXQaa4b4TM9OTfDStzLPvXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGGi62R6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7e1286126so342366266b.0;
        Wed, 12 Feb 2025 04:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739364423; x=1739969223; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tY5gwz0K1pH9LPERb3scr9O6bcGKY6gXL50Bkc8UiRQ=;
        b=dGGi62R6f2iDm2xxUxeY/6JPjFYD+6f3zOk0lF6cO7VUX3bOjqxrPjH/rzmNv9og5E
         A7FNAyfU96MOdR+u+hQslYDruesPHPmG7XhXnOC1OdMBM8ILthRN614PEP/v9LwUgsfG
         I6gYOZaB2dQeXFj6zHUj3dD9+7mx3zF7Yt620KgaqZr4Kae1U4oHmpHSDJ9eNnhp2FPj
         S9j0AMYCJdPgB9odFHkUrHMrwsFZP9Z56GakzkddJXCXzZV+UdLH8RaE5OwsF2zylgnm
         xH6/lGXovOpFPoy+wKe8FDUotSNk+FA4vufFSMV+OhmVIhAYo6YvkgZYZG7qVjfT3j0X
         Ha9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739364423; x=1739969223;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tY5gwz0K1pH9LPERb3scr9O6bcGKY6gXL50Bkc8UiRQ=;
        b=Pm0MeMCQeikH9/2DhdyyU3rzHmeNKQTgTezmZhLDDBmuh4GCsWQD28dohwjyFRmD1c
         HnUYCMhsknXl6CGlEFFtvum/Mr1i5ubvGXGXxrSm5K4LlnaDGC2hocn40bRG44aaTBLt
         KXfqquzjUcixTuNSifJUi952ROIOC/dRtS1D0Ptaa2IqUqAn9PHGYl/uS676u1DLrZTO
         8lftKISQ1pDNgaGsxbucIZk6uzLS1g434/Bmwj18LngGMypjWMM1iiEoDMIoT18CaGEu
         WnbbY9w3b2CYu+EbXg/3CjrV35jl8e0DjOFkcqJmgbxIGzBqG00NRkC9FPOytmxg8XPY
         5BGw==
X-Forwarded-Encrypted: i=1; AJvYcCUPHIYb7x+SpuVTQ/wNVXSnXiW/fW2ez82a98Rn+whyPbLPmG8johYxPkjNrV5vsLCo5tEiq+ORM8A=@vger.kernel.org, AJvYcCVdVjx5X28c3fw3rb9BkZTzx0yswTNNRIc2h328bnqGxB5jZ9J2fl9k9Od184J1wcU+JTKefgiZi9w=@vger.kernel.org, AJvYcCWffrIuAPbe0TtLKA+qU/1SslpHJzCOwvA4FX81HZIvzMh1pmhpHKM/ghGP4ITmhEQ41ImEUUqSsYkDPAoj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4T5mGkUco51EoqODYcjVHv8P7Y0OdqLi7OavJR5nmIZT5wFw
	JXeXWnmhkwzjUZOZqOPq+Chx0bwTkElq2WcfWDndw+LcmJyCwyUZ
X-Gm-Gg: ASbGncvDh/axSGdXRamdyiQG/THYnDe41le5nCl7oepAOtXAA4xfLWqsUADzyqOZim0
	FXC4ngFcuS+aULvOWJZ8T3OWMTnJf8iaFtqIYnZWq9sIbK4hoXFOWQiJA3o7wqZmk6C1C4xrGyB
	csDn5MF8houheDlIBksck+w+qFprYYTX1xWis41ZMAHu8VLIHkA60CbBpB56JXiTOa+Ms2Pc68Q
	1ZLKHpuhf6V55G3wGahJbr42ZzAYkiA6bwPIqXRqLKzCvgRseMGXUWGFSWH297/joYeHy9GaA+3
	8G8nbORv3dEUuisv/J4wm4Mdy+ujvMMTjyTUMQzRL9WaaA==
X-Google-Smtp-Source: AGHT+IEfERvoHB4iH1mmp4qy1uXP3e8Z6S8KEgHPkgkozaQ5CERnYM7uDu5mG84oDMZpogQPQ7Cmag==
X-Received: by 2002:a17:907:2d12:b0:ab7:a39:db4 with SMTP id a640c23a62f3a-ab7f34ac985mr255168666b.57.1739364422581;
        Wed, 12 Feb 2025 04:47:02 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de6e5880b6sm6685818a12.37.2025.02.12.04.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 04:47:02 -0800 (PST)
Message-ID: <b7ed8d0b07e82a637bfc8a3f4d592f0f15ba9688.camel@gmail.com>
Subject: Re: [PATCH v3] intel_idle: introduce 'no_native' module parameter
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: David Arcari <darcari@redhat.com>, kernel test robot <lkp@intel.com>, 
	linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>, Jacob
 Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, Prarit
 Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 12 Feb 2025 14:46:58 +0200
In-Reply-To: <9416ee48-a68a-465e-85be-89d5a53afcd8@redhat.com>
References: <20250211132741.99944-1-darcari@redhat.com>
	 <202502121732.P7lZkbhm-lkp@intel.com>
	 <21e66060c13c6a3cc33592f71cb08975711a6adb.camel@gmail.com>
	 <9416ee48-a68a-465e-85be-89d5a53afcd8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-12 at 07:41 -0500, David Arcari wrote:
> - #ifdef the code that doesn't compile
> - default no_acpi=3Dtrue in the !CONFIG_ACPI_PROCESSOR_CSTATE case
>=20
> I sort of like the second option better, but I worry about the=20
> documentation.=C2=A0 Specifically:
>=20
> "In the case that ACPI is not configured these flags have no impact
> +on functionality."
>=20
> I guess that is still true.
>=20
> Perhaps there is a better option.=C2=A0 What do you think?

I've not been involved into kernel that much for long time. In old days
sprinkling #ifdefs around was an anti-pattern. Most probably nowadays too. =
So
the second option sounds better to me.

Artem.

