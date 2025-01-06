Return-Path: <linux-pm+bounces-19982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C4DA021B1
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 10:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157881638B0
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EBA1D8DEE;
	Mon,  6 Jan 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3HrRguh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7DEEB2;
	Mon,  6 Jan 2025 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155436; cv=none; b=eGnVEdQtzDM/Y8dtqROpVVXJbYFzL00eHgSbJzmyLnWsH2nCFPdS6uYdpXp2awUup8+pnnUeBf+cP6QYtgByZRvPzHKNkFxUIy0Hmeu0NU+dcMx+45Iolf3aNXnzLNiGp/nGHPWeqaoOWPywrOExT/e/vnu59zBOTmNDdl/ON9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155436; c=relaxed/simple;
	bh=y9leoPXPqutzk6SaXbsCxPmtWiljSdQJ8JUFmkkxQpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFc+KcKafNecqVIWssB2hWovd9m7wpU42P2SDz/ChjzhV9l1siwhMbfoQNcRhj2+I0xNfNd6awEAqFxrezpKCT0y1ZKgsA4kkNAAA4BOXOJMMOXiSR0fUpuWe2FOJz4rvYTcpy3maVRwViloBkdEJUP6qaO0+26pyQ1rbTP1o2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3HrRguh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216401de828so189265655ad.3;
        Mon, 06 Jan 2025 01:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736155434; x=1736760234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mFlOOesLzWV9jHl0CvWryDo9a7928bRA/ndvzi3U34=;
        b=T3HrRguhtRfsbE8+bEp0ESDkbXV2tZfizy8ubI5ux9gIlHQDkTqUmYbbI58T6z/Rx8
         m5P5+104iXjSzvX6DATp73keda6jEfsiH10zrYFS+culVAeBHlbkLvzfUG1JoOAoERmZ
         y+ZtWGROaUcmqkLBb6k1+euFs4htlv3qWwRRtz2HFItjxPOcYqufJOwhu+vZkI2fBtut
         pKS9vfWcto6CTRNCuqcjv+p/tvpNrKaFXH37EkcGCSyjIFDtqmFV1TR9zNrbvyJZB2pt
         Hq+N6SVvcwfVYMEh4ehB3pceTuh6ZBbL9ouSmd+4Omq6H1Re7xtdZZS6mF0cHtwstSfh
         Yl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736155434; x=1736760234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mFlOOesLzWV9jHl0CvWryDo9a7928bRA/ndvzi3U34=;
        b=XBuV5mrsDIF/QcHpLmROI3Fi48BekUUMojHi2qF+/ll+b3x7NRKZrm8etfhNySi4+5
         PHWipgCagnrQnV9p2Mj9Bc8KXUYQ7/wWZKdi6sMsDDOEsZzAOIYnPRoVq5fSym3TGcTy
         LEopVHoKTdI5///zb/j6uxQjIyMnsWbxM3sJa5IlG1C6qzPL0dYwFvf5Hx2iJtsz0FwI
         B3qZmvnn4PABIy+bkiKEvZHn3DAW8vZ2NRJahgY7rGN41nJtBIn4lrA1zkjOu0yZX2oy
         pdqeKWj4dKsXGX/dV5jUO+seVP7+4pGZZyubEeHkYpEtf7cYvLQ5iOAuFwvuAtMB626/
         F7sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBLqVwMjoKaPAlavx9t+H0kxk1bzh6hijTo1kTDQYas1YOLao+hWbod0b0Kk4g3rM0jYW1aukHB7Ut@vger.kernel.org, AJvYcCVBlhw9jpbz3KLviHuzgJ4F+ZEpkCn6yIbGGjmSNMIcgxTrC3IXVn/M4dZd8ucRymoqsAAUsGby0fud@vger.kernel.org, AJvYcCVboQnyMoewVtJqLnvWdCSUP+gkyTSChUHc12o4wqRBBUNo7U/GPRLzLD8obZruTT3abp9QWno65MReyO37mg==@vger.kernel.org, AJvYcCWdXCibUrXdqMDLEx9pvNiIzLCOumfX5G0c3ZCaigGqPYEONUkLARv6UCX4Zm+IDLc05MXrmdXqCwSlouQr0SSi4oL4+Q==@vger.kernel.org, AJvYcCX/bTp4EN24fR/ZfhhljjYoTj+5WJNJbZ+eNcJzpslFcXJrOYbCqw/9cUg380uriuf06kMUANgh69AnvZQp@vger.kernel.org, AJvYcCXw3zbhA/je6EQvJQMavkhJ5bBQVnNvphL2KHisqpWqS4OMq+P4ea1IJDVYZoAE3RzA7SShNE6aRHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27sp6nj2vfMp69FfpCgxcXGV0PDD0eEb9hkcqFXOJOedgKrp+
	RZ7s4JgZ14BmtEFMYfrl8CxAEpi8filodRgs5+iK6s+sjUMpUqF3
X-Gm-Gg: ASbGncv7ygCH0B2bITkVvb6mYuERCMuyDdzxPqWlnhoI9L9gtFnoaW/JurOFAlLQoIv
	Rfu+YxfF5Y4KKfro2r5Ig5TOSLJkMC8mZQEd2mzNlyOdlkDPDkCt2brcUwi9YQ7jAscTcXrK24C
	G8TTQvRqP9eYIbfd2oKLzza0mfK3AjLv19CzerBhom4o0ab4sRwVtjxYq/x7f5gYF4hDcW23/ow
	CWS9TlZDYdlvGI8Ccuv1CLOLGpdLy6N+mpew2jDCC9RkXQdF/Wkq4g=
X-Google-Smtp-Source: AGHT+IFNWgvknEaxxE/ZqSDN24QXJsDgOgSDSuKyBvBC/wiI20eX0ttoGoBq9myC9hh4RE2mGnAZNg==
X-Received: by 2002:a17:902:ce86:b0:216:2f7f:ff69 with SMTP id d9443c01a7336-219e6e894c8mr693163105ad.5.1736155433560;
        Mon, 06 Jan 2025 01:23:53 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964a67sm287766465ad.27.2025.01.06.01.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 01:23:53 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: dmitry.baryshkov@linaro.org
Cc: andersson@kernel.org,
	bryan.odonoghue@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mitltlatltl@gmail.com,
	nikita@trvn.ru,
	platform-driver-x86@vger.kernel.org,
	robh@kernel.org,
	sre@kernel.org
Subject: Re: [PATCH 3/5] usb: typec: ucsi: add Huawei Matebook E Go (sc8280xp) ucsi driver
Date: Mon,  6 Jan 2025 17:22:17 +0800
Message-ID: <20250106092224.251115-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <h4icxzxk5fzgkdhhk6disrervqmb4dqe3xlc432k7pgyzsk77u@pyfrrtyjslpo>
References: <h4icxzxk5fzgkdhhk6disrervqmb4dqe3xlc432k7pgyzsk77u@pyfrrtyjslpo>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please ignore the last email, I sent the wrong archive.

On Mon, Jan 6, 2025 at 11:33 AM Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> On Sun, Dec 29, 2024 at 05:05:47PM +0800, Pengyu Luo wrote:
> > On Sun, Dec 29, 2024 at 12:40 PM Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> > > On Sat, Dec 28, 2024 at 01:13:51AM +0800, Pengyu Luo wrote:
> > > > The Huawei Matebook E Go (sc8280xp) tablet provides implements UCSI
> > > > interface in the onboard EC. Add the glue driver to interface the
> > > > platform's UCSI implementation.
> > > >
> > > > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > > > ---
> > > >  drivers/usb/typec/ucsi/Kconfig              |   9 +
> > > >  drivers/usb/typec/ucsi/Makefile             |   1 +
> > > >  drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 481 ++++++++++++++++++++
> > > >  3 files changed, 491 insertions(+)
> > > >  create mode 100644 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> > > >
> > > > diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> > > > index 680e1b87b..0d0f07488 100644
> > > > --- a/drivers/usb/typec/ucsi/Kconfig
> > > > +++ b/drivers/usb/typec/ucsi/Kconfig
> > > > @@ -78,4 +78,13 @@ config UCSI_LENOVO_YOGA_C630
> > > >         To compile the driver as a module, choose M here: the module will be
> > > >         called ucsi_yoga_c630.

[...]

> > > > +
> > > > +     spin_lock_irqsave(&port->lock, flags);
> > > > +
> > > > +     port->ccx = FIELD_GET(GAOKUN_CCX_MASK, dcc);
> > > > +     port->mux = FIELD_GET(GAOKUN_MUX_MASK, dcc);
> > > > +     port->mode = FIELD_GET(GAOKUN_DPAM_MASK, ddi);
> > > > +     port->hpd_state = FIELD_GET(GAOKUN_HPD_STATE_MASK, ddi);
> > > > +     port->hpd_irq = FIELD_GET(GAOKUN_HPD_IRQ_MASK, ddi);
> > > > +
> > > > +     switch (port->mux) {
> > > > +     case USBC_MUX_NONE:
> > > > +             port->svid = 0;
> > > > +             break;
> > > > +     case USBC_MUX_USB_2L:
> > > > +             port->svid = USB_SID_PD;
> > > > +             break;
> > > > +     case USBC_MUX_DP_4L:
> > > > +     case USBC_MUX_USB_DP:
> > > > +             port->svid = USB_SID_DISPLAYPORT;
> > > > +             if (port->ccx == USBC_CCX_REVERSE)
> > > > +                     port->mode -= 6;
> > >
> > > I'd prefer it this were more explicit about what is happening.
> > >
> >
> > If orientation is reverse, then we should minus 6, EC's logic.
> > I will add a comment for it. Actually, this field is unused, I don't
> > find the mux yet, so I cannot set it with this field. But I don't want
> > to make things imcomplete, so keep it.
>
> Which values are you expecting / getting there? The -6 is a pure magic.
> Please replace this with a switch-case or something more obvious.
>

In v2, I have deduced their meaning, with a switch to map them.

> > Let me go off the topic, on my device, I can just use drm_aux_hpd_bridge_notify
> > to enable altmode, usb functions well after I pluged out, I don't need set mode
> > switch(orientation switch is required if orientation is reverse), which is quiet
> > similar to Acer aspire 1. Is mux controlled also by QMP combo phy(see [1])?
> >
> > > > +             break;
> > > > +     default:
> > > > +             break;
> > > > +     }
> > > > +
> > > > +     spin_unlock_irqrestore(&port->lock, flags);
> > > > +}
> > > > +
> > > > +static int gaokun_ucsi_refresh(struct gaokun_ucsi *uec)
> > > > +{
> > > > +     struct gaokun_ucsi_reg ureg;
> > > > +     int ret, idx;
> > > > +
> > > > +     ret = gaokun_ec_ucsi_get_reg(uec->ec, (u8 *)&ureg);
> > > > +     if (ret)
> > > > +             return -EIO;
> > > > +
> > > > +     uec->port_num = ureg.port_num;
> > > > +     idx = GET_IDX(ureg.port_updt);
> > > > +
> > > > +     if (idx >= 0 && idx < ureg.port_num)
> > > > +             gaokun_ucsi_port_update(&uec->ports[idx], ureg.port_data);
> > > > +
> > > > +     return idx;
> > > > +}
> > > > +
> > > > +static void gaokun_ucsi_handle_altmode(struct gaokun_ucsi_port *port)
> > > > +{
> > > > +     struct gaokun_ucsi *uec = port->ucsi;
> > > > +     int idx = port->idx;
> > > > +
> > > > +     if (idx >= uec->ucsi->cap.num_connectors || !uec->ucsi->connector) {
> > > > +             dev_warn(uec->ucsi->dev, "altmode port out of range: %d\n", idx);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     /* UCSI callback .connector_status() have set orientation */
> > > > +     if (port->bridge)
> > > > +             drm_aux_hpd_bridge_notify(&port->bridge->dev,
> > > > +                                       port->hpd_state ?
> > > > +                                       connector_status_connected :
> > > > +                                       connector_status_disconnected);
> > >
> > > Does your platform report any altmodes? What do you see in
> > > /sys/class/typec/port0/port0.*/ ?
> > >
> >
> > /sys/class/typec/port0/port0.0:
> > active  mode  mode1  power  svid  uevent  vdo
> >
> > /sys/class/typec/port0/port0.1:
> > active  mode  mode1  power  svid  uevent  vdo
> >
> > /sys/class/typec/port0/port0.2:
> > active  mode  mode1  power  svid  uevent  vdo
> >
> > /sys/class/typec/port0/port0.3:
> > active  mode  mode2  power  svid  uevent  vdo
> >
> > /sys/class/typec/port0/port0.4:
> > active  mode  mode3  power  svid  uevent  vdo
>
> please:
>
> cat /sys/class/typec/port0/port0*/svid
> cat /sys/class/typec/port0/port0*/vdo
>

svid:
8087
ff01
12d1
12d1
12d1

vdo:
0xff000001
0xff1c1c46
0xff000001
0xff000002
0xff000003

> If DP is reported as one the altmodes, then it should be using the
> DisplayPort AltMode driver, as suggested by Heikki.
>

But this paltform cannot access to the partner device, related API
requires a partner.

BTW, it is unnecessary that implementing/call a DP Altmode driver for
this platform. Currently, we can enter altmode with a HPD event notify.
This point is quiet similar to Acer aspire 1. I mentioned this when we
last talked about minus 6.

> > > > +
> > > > +     gaokun_ec_ucsi_pan_ack(uec->ec, port->idx);
> > > > +}
> > > > +
> > > > +static void gaokun_ucsi_altmode_notify_ind(struct gaokun_ucsi *uec)
> > > > +{
> > > > +     int idx;
> > > > +
> > > > +     idx = gaokun_ucsi_refresh(uec);
> > > > +     if (idx < 0)
> > > > +             gaokun_ec_ucsi_pan_ack(uec->ec, idx);
> > > > +     else
> > > > +             gaokun_ucsi_handle_altmode(&uec->ports[idx]);
> > > > +}
> > > > +
> > > > +/*
> > > > + * USB event is necessary for enabling altmode, the event should follow
> > > > + * UCSI event, if not after timeout(this notify may be disabled somehow),
> > > > + * then force to enable altmode.
> > > > + */
> > > > +static void gaokun_ucsi_handle_no_usb_event(struct gaokun_ucsi *uec, int idx)
> > > > +{
> > > > +     struct gaokun_ucsi_port *port;
> > > > +
> > > > +     port = &uec->ports[idx];
> > > > +     if (!wait_for_completion_timeout(&port->usb_ack, 2 * HZ)) {
> > > > +             dev_warn(uec->dev, "No USB EVENT, triggered by UCSI EVENT");
> > > > +             gaokun_ucsi_altmode_notify_ind(uec);
> > > > +     }
> > > > +}
> > > > +

[...]

> > > > +
> > > > +static void gaokun_ucsi_register_worker(struct work_struct *work)
> > > > +{
> > > > +     struct gaokun_ucsi *uec;
> > > > +     struct ucsi *ucsi;
> > > > +     int ret;
> > > > +
> > > > +     uec = container_of(work, struct gaokun_ucsi, work);
> > > > +     ucsi = uec->ucsi;
> > > > +
> > > > +     ucsi->quirks = UCSI_NO_PARTNER_PDOS | UCSI_DELAY_DEVICE_PDOS;
> > >
> > > Does it crash in the same way as GLINK crashes (as you've set
> > > UCSI_NO_PARTNER_PDOS)?
> > >
> >
> > Yes, no partner can be detected, I checked. I think it is also handled by
> > the firmware As you said in [2]
> > > In some obscure cases (Qualcomm PMIC Glink) altmode is completely
> > > handled by the firmware. Linux does not get proper partner altmode info.
>
> This is a separate topic. Those two flags were added for a very
> particular reason:
>
> - To workaround firmware crash on requesting PDOs for a partner
> - To delay requeting PDOs for the device because in the unconnected
>   state the GET_PDOS returns incorrect information
>
> Are you sure that those two flags are necessary for your platform?
>

Alright, I think I got things mixed up. Actually PDO requires UCSI only,
not a partner device.

I think I will remove it in v3 if it works well during the time. Rencetly,
this platform works well without it. Thanks for pointing out.

> >
> > > > +
> > > > +     ssleep(3); /* EC can't handle UCSI properly in the early stage */
> > > > +
> > > > +     ret = gaokun_ec_register_notify(uec->ec, &uec->nb);
> > > > +     if (ret) {
> > > > +             dev_err_probe(ucsi->dev, ret, "notifier register failed\n");
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     ret = ucsi_register(ucsi);
> > > > +     if (ret)
> > > > +             dev_err_probe(ucsi->dev, ret, "ucsi register failed\n");
> > > > +}
> > > > +
> > > > +static int gaokun_ucsi_register(struct gaokun_ucsi *uec)
> > >
> > > Please inline
> > >
> >
> > I see.
> >
> > Best wishes
> > Pengyu
> >
> > [1] https://elixir.bootlin.com/linux/v6.12.5/source/drivers/phy/qualcomm/phy-qcom-qmp-combo.c#L2679
> > [2] https://lore.kernel.org/lkml/20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org


Best Wishes,
Pengyu

