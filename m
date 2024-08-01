Return-Path: <linux-pm+bounces-11812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 698A3945042
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 18:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154181F225C6
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 16:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A581B3748;
	Thu,  1 Aug 2024 16:13:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54513B79F;
	Thu,  1 Aug 2024 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528818; cv=none; b=IhmrYGUU+KKvw60Q3BDaXjGZBQv6qrb2d7qSzx0Vkjx14iBENfcZkxdyXsPbxEicG3xk3Rxxug1oYsdP/h1ammvNpWb61kzJHDlqEBvaAK494AH8fzeKRC33gJL5J6yTqCPOrhDqK9hdhO08y6UL/rNIvu/4n1VVF0TA06yNe0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528818; c=relaxed/simple;
	bh=e12nl0o1Ajo9kjJW9t6rKls4XXt3i97tBIEnjI3JGlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUGFnNP2x4VWjCB6HkbG8BXXatjBEqpYf09xf5guWtQuvVmeuzCB3G92nwpwNmYiKxD8QSUBWYZLQQOBYC8lgQO2ShTnrs5DS76QEPa+CtkDS2AA7ksjmhXkb1Wkpm06bb8dl0VnMwM/XUX/EJhbYy2jMqxuVe23z0RhZoB402U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-66a048806e6so58258717b3.3;
        Thu, 01 Aug 2024 09:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528815; x=1723133615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZU8AcYf0RvO9EMRX/7NVbpNBY0T/I+LMhz17A8FopU0=;
        b=Abb3VW+CHzXscCrLclDJ4AKstPoBoW6UhzRKEavYW4LP1abZ55tjHwR2DRL36U5O0f
         ChVbWVCKOyoBTFMt1RS5CG/sxx3I8wi4ym9Do/1VdP+h8MSmg1s+j3+c2owzRXDiXuay
         uKtI5B1q5CWSy2As4giqY6wn6/kPnQWfy1uXLQjwAJoT7wQanirKPCJr8oQb/VfJdhD8
         UMS6mtL4lRqnguKdTHku+8ikbQ0GgPHNqcQHwYRjKN9Hij/dV5P7jQao0PU6ykbAZDUV
         YiMz8OiYyWm+f8CUCxU72UcDO6rIYNd566fvtJ+HSadReHGvW9eisWpXhd56jZ7y81Wp
         Evog==
X-Forwarded-Encrypted: i=1; AJvYcCUf4Ld1TqLh6bvH4sFrNGNhS6tvjG0k+kl6FLKarwAx8fRlLNX2Mw1djIQIRrIUXeEUNPkKUcKDmdCAghIl9DicXGtp0aN7dPRumy00gn9ufVxVAqC+YxsKLTIwXen9Th9Fv3SBtMWixACc5uCt+iNXbyehnSKTlHXFNS9soN9KC0oBJXO9JSK48QeGZKvRAzSl082ahi/glphPsP+GH3mz7JMeqKzHSksDQmVWkOA2G9bDYLLkRKvC4C6bVEISqJ8=
X-Gm-Message-State: AOJu0YzzgpAoz7ZyL2IczPuqH5vty6Z3qP4Uv4pXqxBv2kaoImznPBlz
	UeKxCTj78SQ6BWtKjRNeLMBe8s1+bAIrzABhSyOoOMXHI9ISY1SGtp0HLv6y
X-Google-Smtp-Source: AGHT+IFmY6GlwvHD4+zvbL3OmNhSmfHHIqvlxzKyiWbxQn8+TMl/u5g7KKvLrFxLjVScg6u+NqFugw==
X-Received: by 2002:a81:9c0f:0:b0:645:8fb:71c8 with SMTP id 00721157ae682-68964392be3mr5618377b3.37.1722528815304;
        Thu, 01 Aug 2024 09:13:35 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd926asm33774987b3.10.2024.08.01.09.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 09:13:35 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66a048806e6so58258447b3.3;
        Thu, 01 Aug 2024 09:13:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZW4f6oF+WAaH+rxfq/ySj2attj/oxTkCcYoXFLzDDTOdmRkC8QyU5XD88lZ0JxGNsEEbSQqeuS+q+oI/GA+8Vxkcj32eMQLKJ95dycKE3dPiB69QBrPAkbdhnv8EYFFvFWKe8SReIKxdsbev0eTs36pJhugtq+gGMW2yt3nABV+K3VQ9HTgyML6LO5KsTOM8r5Pvbs8nBrgwqS+Z9hCEzK3mKqISsg1Zht24auNnJkqP6tLT8gq4xwTNFG//rqI0=
X-Received: by 2002:a0d:da86:0:b0:665:b876:e35f with SMTP id
 00721157ae682-6896141ae5amr6046747b3.22.1722528814853; Thu, 01 Aug 2024
 09:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com> <20240422105355.1622177-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240422105355.1622177-9-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Aug 2024 18:13:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhRRdfoqg_o6bU7jjt5_Di0=z7MJ4fMh=MJ0m8=u4tgg@mail.gmail.com>
Message-ID: <CAMuHMdWhRRdfoqg_o6bU7jjt5_Di0=z7MJ4fMh=MJ0m8=u4tgg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] arm64: dts: renesas: r9a08g045: Update
 #power-domain-cells = <1>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, magnus.damm@gmail.com, ulf.hansson@linaro.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Mon, Apr 22, 2024 at 12:54=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev>=
 wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Update CPG #power-domain-cells =3D <1> and move all the IPs to be part of=
 the
> IP specific power domain as the driver has been modified to support
> multiple power domains.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Now the watchdog fixes are in v6.11-rc1, I will queue this in
renesas-devel for v6.12.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

