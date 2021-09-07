Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9102403056
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 23:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbhIGVh2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 17:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbhIGVh2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 17:37:28 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694CFC061757
        for <linux-pm@vger.kernel.org>; Tue,  7 Sep 2021 14:36:21 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id b4so133144qtx.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Sep 2021 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hHHNGQ0/c7grA1NVwCheQIrG1pechrzo95jBO8E7AQ=;
        b=AKZ2P6Wl/6ltmXc31yGRxxU9WhQSvfbxpWyMH+icfJn8YJp8gC3gWm1RRoUWIPks3L
         11ZrJLEKD70D6kx8vG3YvmAFi79X6Jz1k5+0YfKzorgKUed8Ikjk3brIKvCUiQFBq/Q4
         dhpboaWll2+31bUgTQ2oVPxe+LZApI/X8xmFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hHHNGQ0/c7grA1NVwCheQIrG1pechrzo95jBO8E7AQ=;
        b=ku22qwLk+FZQf/H5m4oJYVF75tP96SCTnZkdhP+flRBxZ0kfpEkwrU9KdTDc3B/9Zn
         Kfe1iUQwfa2WqAs0BfDHO6QymxQhYe7Bso5D6csbPGMRSh3KAjw8zThg6xe92EI93J+0
         8C2hYKFHSUdOugYeFG23915y8qwSljx0v+j6tXRTWSmdThFEWffQ2g66G4gtBCjokWT5
         +k2UrDllHtFPU0oRf3g0UZT0+aZ1xSiEoeHGc+ImcQ2KFQtXNXFWmzz5BWFB/oTpb9O5
         tRLZnafrs22vu9o47U4e8XnooD1o2+zaZ49mSN/PsFTmvfb4AWsC9dR7tedBJXln0v4B
         GtqA==
X-Gm-Message-State: AOAM530zlvGfNYd9/9hRLb9p4Hx3vrt6IcVPXNVlnf6dn6EV4l+oC0S7
        VrHKN6Hto5kIlK8O9A/pxmgUOqXgu2b3UNpgk6XOPQ==
X-Google-Smtp-Source: ABdhPJzCE/J7vER9ZmCmgpg6VxT4lhFi9fs5sZzobC5XbJ0egZtsV41FrlN6xKU7xP6NWeZycgKv+gIAlQRmk5GBZuE=
X-Received: by 2002:ac8:4b43:: with SMTP id e3mr551768qts.312.1631050580551;
 Tue, 07 Sep 2021 14:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-2-pmalani@chromium.org> <20210903064701.GA3515@jackp-linux.qualcomm.com>
 <20210903180507.GB3515@jackp-linux.qualcomm.com>
In-Reply-To: <20210903180507.GB3515@jackp-linux.qualcomm.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 7 Sep 2021 14:36:09 -0700
Message-ID: <CACeCKadN3kFYgVhCU0GbhBth8DQp0ZJ7y=ev7O=VPtpedKwsxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] usb: pd: Increase max PDO objects to 13
To:     Jack Pham <jackp@codeaurora.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" 
        <linux-pm@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jack,

Thanks for taking a look at the patch.

On Fri, Sep 3, 2021 at 11:05 AM Jack Pham <jackp@codeaurora.org> wrote:
>
> On Thu, Sep 02, 2021 at 11:47:01PM -0700, Jack Pham wrote:
> > Hi Prashant,
> >
> > On Thu, Sep 02, 2021 at 02:34:58PM -0700, Prashant Malani wrote:
> > > Increase the max number of PDO objects to 13, to accommodate the extra
> > > PDOs added as a part of EPR (Extended Power Range) operation introduced
> > > in the USB PD Spec Rev 3.1, v 1.0. See Figure 6-54 for details.
> > >
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > ---
> > >  include/linux/usb/pd.h | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> > > index 96b7ff66f074..7e8bdca1ce6e 100644
> > > --- a/include/linux/usb/pd.h
> > > +++ b/include/linux/usb/pd.h
> > > @@ -201,7 +201,13 @@ struct pd_message {
> > >  } __packed;
> > >
> > >  /* PDO: Power Data Object */
> > > -#define PDO_MAX_OBJECTS            7
> > > +
> > > +/*
> > > + * The EPR (Extended Power Range) structure is a superset of the SPR (Standard Power Range)
> > > + * capabilities structure, so set the max number of PDOs to 13 instead of 7. On SPR-only systems,
> > > + * objects 8 through 13 will just be empty.
> > > + */
> > > +#define PDO_MAX_OBJECTS            13
> >
> > Hmm this might break the recent change I made to UCSI in commit
> > 1f4642b72be7 ("usb: typec: ucsi: Retrieve all the PDOs instead of just
> > the first 4").
> >
> >  520 static void ucsi_get_src_pdos(struct ucsi_connector *con, int is_partner)
> >  521 {
> >  522         int ret;
> >  523
> >  524         /* UCSI max payload means only getting at most 4 PDOs at a time */
> >  525         ret = ucsi_get_pdos(con, 1, con->src_pdos, 0, UCSI_MAX_PDOS);
> >  526         if (ret < 0)
> >  527                 return;
> >  528
> >  529         con->num_pdos = ret / sizeof(u32); /* number of bytes to 32-bit PDOs */
> >  530         if (con->num_pdos < UCSI_MAX_PDOS)
> >  531                 return;
> >  532
> >  533         /* get the remaining PDOs, if any */
> >  534         ret = ucsi_get_pdos(con, 1, con->src_pdos, UCSI_MAX_PDOS,
> >  535                             PDO_MAX_OBJECTS - UCSI_MAX_PDOS);
> >                                ^^^^^^^^^^^^^^^
> > This routine calls the UCSI GET_PDOS command for up to 4 PDOs at a time
> > since that's the most the return payload can carry.  Currently this
> > assumes that we'd only need to request the PPM at most twice to retrieve
> > all the PDOs for up to a maximum of 7 (first request for 4 then again if
> > needed for the remaining 3).  I'm not sure if any existing UCSI FW would
> > be updatable to support more than 7 PDOs in the future, much less
> > support EPR.  In fact, current UCSI 1.2 spec [1] Table 4-34 mentions PDO
>
> Sorry, forgot the footnote with the link to the spec:
> [1] https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/usb-type-c-ucsi-spec.pdf
>
> > offset valid values are 0-7 and anything else "shall not be used", so I
> > don't know how UCSI will eventually cope with EPR without a spec update.
> >
> > So if this macro changes to 13 then this call would result in a call to
> > the UCSI GET_PDOS command passing num_pdos == 13-4 = 9 which would
> > probably result in an error from the PPM FW.  So we might need to retain
> > the maximum value of 7 PDOs at least for UCSI here.  Maybe that means
> > this UCSI driver needs to carry its own definition of
> > UCSI_MAX_TOTAL_PDOS=7 instead of using PDO_MAX_OBJECTS?

Thanks for pointing this out. We can perhaps just add another macro
for EPR_PDO_MAX_OBJECTS, and leave the current macro as is for now.

Best regards,
