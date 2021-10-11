Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4DF429998
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 01:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbhJKXHc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 19:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbhJKXH3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 19:07:29 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77518C06161C
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 16:05:28 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r16so17864314qtw.11
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 16:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R8fdhpqjIZc5EtaDg2AIHsp2JYrHU9qkmtFNONywXlw=;
        b=bcQYPbnPnO7DKhRn1ghmHgQGV1QnAk0vGUcGkFvX9uJml6DMK21V1u0BNUEloYjEr0
         ErJ+bctjGQsZjeUZVjNhWrx5FrPRdNIn09wQz25g7oVj0l7J8RllwbG/UlTZ3Zp2hsqO
         hD3ESj1o1p6IZyaabEk1au8TGENnPAm3WtJ9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8fdhpqjIZc5EtaDg2AIHsp2JYrHU9qkmtFNONywXlw=;
        b=ofIqRwNI+jrtYmFDQdribhzoFqAgtCHKfqLBMJvfIXJ8qzCeZAiOYoybTZhoC/Sh17
         yDKjxTxgVZFJ0Sq44MMmfMnV90QGnfZMLXPSQIxkjRDW5elQROQymPt4nR3bX+wCQjAh
         nUwD8pAaDBw/nqIzYm/93TC2s1FvSn+WcIYsCQ/MiNQIzLN7A4Pvv64yalM1bDUXtN/r
         RTu9TFZ2pkU14IfEAzK1elk7BW4HRW4+8s8kIZfQN2wX44mEpq9J+cPAAfqMbrF1Zira
         jBehzuMjm16CQ8Zth4mn3S3klvgD3EElY9equCVY2LfKAEVsY2B8F8xo0rJ1eFI7dDO4
         pz8Q==
X-Gm-Message-State: AOAM530nGsy/gdsFhcVrpw60Hjsl+igvNOfnrMdG+MRPKFUWX1SCXVUu
        8NSXimV8/eklzW/MoDGdP32XkQF8rinYtC/IDD1Onw==
X-Google-Smtp-Source: ABdhPJzvF8qytwh2h91FJkpzQMjJdAL2tkDCmGI7jgA2iI+BHf1BJG0GwrnwgdBEKmMzvU5a+4mKPKPyUwDK8RBTCG8=
X-Received: by 2002:ac8:4155:: with SMTP id e21mr18459684qtm.312.1633993526899;
 Mon, 11 Oct 2021 16:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com> <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUB16up3JDwi3HfI@kuha.fi.intel.com> <YULwz8NsoA3+vrhA@google.com>
 <YUMbGp0aemx1HCHv@kuha.fi.intel.com> <DB9PR10MB46525E6CA4C6BB101059D93C80DC9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUm5sdbceMcDTvYj@kuha.fi.intel.com> <DB9PR10MB46524E3817FB4D836CDC13E180A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CACeCKaem93dbJ11qOG=a+MkJhSrp0Nx-UAPG00Q-5WwMriJD0A@mail.gmail.com> <YWAnA1mc5CrlEs7H@kuha.fi.intel.com>
In-Reply-To: <YWAnA1mc5CrlEs7H@kuha.fi.intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 11 Oct 2021 16:05:15 -0700
Message-ID: <CACeCKacPdA0NoEcG92V8-SnYqA-93kUjNdbW-sa7DcCDTodrNw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] power: supply: Add support for PDOs props
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Benson Leung <bleung@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "badhri@google.com" <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Heikki,

On Fri, Oct 8, 2021 at 4:10 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Oct 07, 2021 at 03:32:27PM -0700, Prashant Malani wrote:
> > Hi folks,
> >
> > Thanks for the comments and discussion on this RFC series.
> >
> > On Fri, Sep 24, 2021 at 8:38 AM Adam Thomson
> > <Adam.Thomson.Opensource@diasemi.com> wrote:
> > >
> > > On 21 September 2021 11:54, Heikki Krogerus wrote:
> > >
> > > > If we can leave the decision about the selection to TCPM, that would
> > > > be great! I'm not against that at all. As I said, I have not though
> > > > through the control aspect. Right now I'm mostly concerned about how
> > > > we expose the information to the user. The only reason why I have
> > > > considered the control part at all is because how ever we decide to
> > > > expose the information to the user, it has to work with control as
> > > > well.
> > >
> > > Well part of the discussion has to be about the role that the user plays in
> > > the control. What does and doesn't need to be controlled further up the stack,
> > > and what will be taken care of by, for example, TCPM? Surely that dictates to
> > > some degree what and how we expose all of this? Right now we have a simple means
> > > to read and control voltages and currents through a PSY class, without the need
> > > for the user to know any details of what a PDO/APDO is. Do we continue with
> > > abstracting away to the user or instead let the user decipher this itself and
> > > decide? Am just trying to understand the needs going forward.
> > >
> > > > The final PSYs and the supply chains they create as well as the
> > > > individual properties I'm more than happy to talk about, but having a
> > > > separate object for the smallest thing that we can see (PDO) is the
> > > > right thing to do here IMO. Trying to concatenate things into single
> > > > objects especially in sysfs, despite how nice it always would seem,
> > > > has taken me to the brink of disaster in the past far too many times.
> > > >
> > > > In this case we don't need to take the risk of having to duplicated
> > > > information or in worst case deprecate something that is also exposed
> > > > to the sysfs in the future.
> > > >
> > > > So the question is not why should we registers every individual PDO
> > > > separately. The question is, why shouldn't we do that? And saying that
> > > > it's "heavyweight" I'm afraid is not good enough. :-)
> > >
> > > That was my initial feeling on the suggestion based on the idea of a PSY per PDO
> > > and I still don't feel that fits as your creating a whole class of resources
> > > to expose something that's pretty small. To me the PSY represents the source as
> > > whole, and the PDOs are simply options/configurations for that source. If we're
> > > needing to expose PDOs then I don't disagree with separating them out
> > > individually and I certainly wouldn't want that all concatenated as one
> > > property. However I think something like dynamically generated properties
> > > might be a nicer solution to expose each PDO, or even groups of properties if
> > > you wanted to split PDOs even further into constituent parts to the user.
> >
> > To downscope this issue for the time being, one of our immediate goals
> > is to expose the PDOs
> > to userspace for metrics reporting and potentially for some power
> > policy control through other
> > channels (like Chrome OS Embedded Controller).
> >
> > Would it be acceptable to revise this series to drop the power supply
> > support for now (since I don't yet
> > see a consensus on how to implement it for the partner), and just add
> > sysfs nodes for each PDO ?
> > This would be akin to how it's being done for identity VDOs right now.
> >
> > So we would have :
> >
> > /sys/class/typec/<port>-partner/source_pdos/pdo{1-13}
> >
> > and
> >
> > /sys/class/typec/<port>-partner/sink_pdos/pdo{1-13}
> >
> > and similarly for the port device.
> >
> > If we want to add additional parsing of the  Fixed Supply PDO into
> > individual properties for the partner/port,
> > those can of course be added later.
> >
> > WDYT?
>
> I don't think we should use sysfs to expose and control any of these
> objects. It does not really matter under which subsystem we are
> working. Sysfs is just the wrong interface for this kind of data.
>
> I'm now preparing a proof-of-concept patches where I create character
> device for every USB PD capable device (port, plug and partner). The
> idea is that we could use those char devices to tap into the USB PD
> protocol directly. Right now I'm thinking the nodes would look like
> this (with the first Type-C port):
>
>         /dev/pd0/port
>         /dev/pd0/plug0 - you only get this node with full featured cables
>         /dev/pd0/plug1 - ditto
>         /dev/pd0/partner - and this is here only if you are connected
>
> So in this case you would use those char devices to send the actual
> Get_Source_Cap and Get_Sink_Cap messages to get the PDOs.

Interesting. Is this ABI going to need to be defined explicitly, or is the plan
to just mimic the PD protocol messages as much as possible?

I'm assuming the PDOs themselves will still need to be stored in the connector
class port/partner data structures, right?

>
> The problem is that it's not going to be possible to always support
> every type of command. For example with UCSI we are pretty much
> limited to the capability control messages. But I still think this is
> the right way to do this.
>
> Let me know what you think.

Sounds good. I look forward to trying out your series when it's ready.

Best regards,

-Prashant
