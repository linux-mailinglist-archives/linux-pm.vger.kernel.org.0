Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D092B403189
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 01:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbhIGXaJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 19:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240690AbhIGXaJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 19:30:09 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF9AC06175F
        for <linux-pm@vger.kernel.org>; Tue,  7 Sep 2021 16:29:02 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s29so437016pfw.5
        for <linux-pm@vger.kernel.org>; Tue, 07 Sep 2021 16:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=huc226miYakXtQslcOJ5OFd9dcBX+yoxXSmw1/JBDr8=;
        b=g4QFCzGnJKWqHaVTPchOeRfVnrN2KkPvCP/gI9KbDmC0V7x92NAtrU/9bnOsKqcJv5
         DBNqQTLuzd/4bv0C4E9Cr28bZNRF0OYpTNgd00YAjWtfjS08ktJsotXMkcW2lnrzTV3q
         4G9wdJuSLftnVsmdarmsmJ9zUwx4/Gl2ZEbOuhURkRV4CH4A6+fAdexIEeZM13Y4L/au
         oHk0yxTlw16XOXS/8BNP5gbkx2q3D2WbKCZ0luZtRrY/VRTBVXqM18Kl5cguzhBZvXwn
         O5a3FOt7R0X+6n/21N+uJfdPD5FIzWWv7NKrpYhbeiWlF0/1snB/CXtefy3SGQoG/JrQ
         MnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=huc226miYakXtQslcOJ5OFd9dcBX+yoxXSmw1/JBDr8=;
        b=SzpwE6rpzOXFLdfX1K7DMlYIVtRYdYhMdcLkuGBozsmtdPBL7bmImF73Aq9ClsgRCX
         RfpgdZEjeGMel/dWDwtH380i+5QF2UfyvLrtf6dtZRkp7HT5g61/Xn0qUShP17Q+J9Rc
         cQVYqft/Sh7ZGqjoQWf1vier7RMzyaXULSJGaWDxT7EqMudC+8EXk3gmX37yCUN0aCc0
         nLSbrKMzynlFz90pcCZ00JSkWq9+P9CkUbJ3LMAKBjJRZ1ifao05Qef4skHczCofMY2r
         yVWTCPDXFR3GXqfj1p5tQWFbJPiGH9FUjRS26z/Y9D9TZ2Xh064qOCZgABEWkSKvJbRN
         IQug==
X-Gm-Message-State: AOAM530TNTTyVqwSKLLzGpmcYcN2bwRTpagpbS29G6UF+FYf4RDfCyKj
        MV9gfeA2nsB5dstjL4sIsfTGlw==
X-Google-Smtp-Source: ABdhPJxIQ375xdhgXCCw5RZhtV4j3yygstRnelBaCmxFSUWle29yKPlWQoQ44FqgATE53J2mikyPJQ==
X-Received: by 2002:a63:f050:: with SMTP id s16mr772788pgj.258.1631057340982;
        Tue, 07 Sep 2021 16:29:00 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:8525:5337:1a6c:f8af])
        by smtp.gmail.com with ESMTPSA id z9sm163607pfk.28.2021.09.07.16.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 16:28:59 -0700 (PDT)
Date:   Tue, 7 Sep 2021 16:28:53 -0700
From:   Benson Leung <bleung@google.com>
To:     Jack Pham <jackp@codeaurora.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org, bleung@chromium.org,
        heikki.krogerus@linux.intel.com, badhri@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 1/3] usb: pd: Increase max PDO objects to 13
Message-ID: <YTf1tTvfEMzTawwK@google.com>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-2-pmalani@chromium.org>
 <20210903064701.GA3515@jackp-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dU2rkRBfuzWCPsob"
Content-Disposition: inline
In-Reply-To: <20210903064701.GA3515@jackp-linux.qualcomm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dU2rkRBfuzWCPsob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jack,

On Thu, Sep 02, 2021 at 11:47:01PM -0700, Jack Pham wrote:
> Hi Prashant,
>=20
> On Thu, Sep 02, 2021 at 02:34:58PM -0700, Prashant Malani wrote:
> > Increase the max number of PDO objects to 13, to accommodate the extra
> > PDOs added as a part of EPR (Extended Power Range) operation introduced
> > in the USB PD Spec Rev 3.1, v 1.0. See Figure 6-54 for details.
> >=20
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  include/linux/usb/pd.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> > index 96b7ff66f074..7e8bdca1ce6e 100644
> > --- a/include/linux/usb/pd.h
> > +++ b/include/linux/usb/pd.h
> > @@ -201,7 +201,13 @@ struct pd_message {
> >  } __packed;
> > =20
> >  /* PDO: Power Data Object */
> > -#define PDO_MAX_OBJECTS		7
> > +
> > +/*
> > + * The EPR (Extended Power Range) structure is a superset of the SPR (=
Standard Power Range)
> > + * capabilities structure, so set the max number of PDOs to 13 instead=
 of 7. On SPR-only systems,
> > + * objects 8 through 13 will just be empty.
> > + */
> > +#define PDO_MAX_OBJECTS		13
>=20
> Hmm this might break the recent change I made to UCSI in commit
> 1f4642b72be7 ("usb: typec: ucsi: Retrieve all the PDOs instead of just
> the first 4").
>=20
>  520 static void ucsi_get_src_pdos(struct ucsi_connector *con, int is_par=
tner)
>  521 {
>  522         int ret;
>  523
>  524         /* UCSI max payload means only getting at most 4 PDOs at a t=
ime */
>  525         ret =3D ucsi_get_pdos(con, 1, con->src_pdos, 0, UCSI_MAX_PDO=
S);
>  526         if (ret < 0)
>  527                 return;
>  528
>  529         con->num_pdos =3D ret / sizeof(u32); /* number of bytes to 3=
2-bit PDOs */
>  530         if (con->num_pdos < UCSI_MAX_PDOS)
>  531                 return;
>  532
>  533         /* get the remaining PDOs, if any */
>  534         ret =3D ucsi_get_pdos(con, 1, con->src_pdos, UCSI_MAX_PDOS,
>  535                             PDO_MAX_OBJECTS - UCSI_MAX_PDOS);
> 				 ^^^^^^^^^^^^^^^
> This routine calls the UCSI GET_PDOS command for up to 4 PDOs at a time
> since that's the most the return payload can carry.  Currently this
> assumes that we'd only need to request the PPM at most twice to retrieve
> all the PDOs for up to a maximum of 7 (first request for 4 then again if
> needed for the remaining 3).  I'm not sure if any existing UCSI FW would
> be updatable to support more than 7 PDOs in the future, much less
> support EPR.  In fact, current UCSI 1.2 spec [1] Table 4-34 mentions PDO
> offset valid values are 0-7 and anything else "shall not be used", so I
> don't know how UCSI will eventually cope with EPR without a spec update.
>=20

I've had a conversation with Dmitriy Berchanskiy at Intel (the UCSI WG Chai=
r)
about this, and it sounds like the UCSI spec is planned on being revved
(post R2.0) in order to support the additional messages and expanded struct=
ures
of USB PD R3.1 around EPR.

> So if this macro changes to 13 then this call would result in a call to
> the UCSI GET_PDOS command passing num_pdos =3D=3D 13-4 =3D 9 which would
> probably result in an error from the PPM FW.  So we might need to retain
> the maximum value of 7 PDOs at least for UCSI here.  Maybe that means
> this UCSI driver needs to carry its own definition of
> UCSI_MAX_TOTAL_PDOS=3D7 instead of using PDO_MAX_OBJECTS?
>=20

Prashant mentioned this as well, but maybe it makes sense to define a separ=
ate
EPR_PDO_MAX_OBJECTS to handle the EPR case, as there are completely separate
underlying PD messages (EPR_Source_Capabilities) where we expect up to 13
objects, and the classic SPR Source and Sink capabilities will still have t=
he
7 object limit.

Thanks,
Benson

> Jack
> --=20
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--dU2rkRBfuzWCPsob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYTf1tQAKCRBzbaomhzOw
wlRvAPwPZTx65uU6EEUXq7sH6/pz2lo/Y6+g2Brgeyph8nhZuAD/U0LKYsc1cWoX
y/jbqXCGXSm7zQBhJ3Xrs0fDV2B2Mw8=
=gobX
-----END PGP SIGNATURE-----

--dU2rkRBfuzWCPsob--
