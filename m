Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7FF6162472
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 11:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgBRKWb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 05:22:31 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:40414 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgBRKW3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 05:22:29 -0500
Received: by mail-lj1-f172.google.com with SMTP id n18so22271490ljo.7
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2020 02:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W72sztoRh+McmphKRgX4tOdWz/1TaY4NH71C48f69Do=;
        b=G4ZUB49J3pMicoq7W/iK1YVpTZTH9Z4LyNa1uZLGY/eTKKilcqPAWRNGmf1h1NXJcf
         QrLjvCrvjaDz8+WlTUj6/Hfpaa0LFJkRBfHF3arTL4sDBATuRHB9zyESubreMSNtSuWx
         tKylmJtPD41ywj85q+Dg10/WN6XFllZO+lYFnHsjEpb4NkUx+BfNqnWelqLQ54/XKc/x
         yO7kvZdPCHeTMJubju7OQVWD+ak5O08xiXhpRi0ef9VS8mmk5Cnkgeisuup0OOMAp2LE
         /Pf6Md6i2jfF60kxqRwzMU/vkRpgFEhVxOrKcy61l0LmYKwnWcf4NK8wd9CmPqaTBzZ3
         k3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W72sztoRh+McmphKRgX4tOdWz/1TaY4NH71C48f69Do=;
        b=jRp5gdlhZTrAoQAsz4VbOGiQgB2rDMeGi6FWlHXO3nJlckuEkuaEcuL6BPL+oiebQi
         zg2FF9aKFkA7yAVUfuLDG4j8mwEKYU/RDMolGPCU9A2yvGosNaaTJZlbaj4tdsLQAfi3
         /FhjjWvq2J4bEzixKe8TqHs18bhaeSuYXSN1eRaWwQ5GKsojyIJ9Tpx4CH0oirbXdnrj
         8qvCsTi7Tyl4koPoPCQPXErl/5Mlz13VcIQp5FaSo4DVmJeHPFSXROzL4zkrPMqujzYN
         fMlR3cYfJ6919CeedAJs6QTkRFUBRMFxSAQeqSlfd1J2mMPijFxnmIqX7nKms4eQWJK2
         Evvw==
X-Gm-Message-State: APjAAAVaPp/9PNbPM3oBLE9uBFU7MQRXK8mbd2pqQgPUWCCQYSuhQt9b
        FKxvJn5VAYdCQrKyKmnFcKkbVg==
X-Google-Smtp-Source: APXvYqzHVkBWWMyB11qGkZJ5O1yDGNinCi2d0MWFVrLqBUQwfpEWBEaci9jMNx2iXoh6EuufcRXiuQ==
X-Received: by 2002:a2e:5854:: with SMTP id x20mr11740789ljd.287.1582021346380;
        Tue, 18 Feb 2020 02:22:26 -0800 (PST)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id m21sm1937481lfb.59.2020.02.18.02.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 02:22:25 -0800 (PST)
Date:   Tue, 18 Feb 2020 11:22:24 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Renesas R-Car thermal drivers
Message-ID: <20200218102224.GA812084@oden.dyn.berto.se>
References: <20200216130252.125100-1-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdUdBVwAbG8Qicg3_aKvwjq91QJWS5FQwM6NPdgbyP2Wzw@mail.gmail.com>
 <20200217101114.GO3013231@oden.dyn.berto.se>
 <87zhdg2293.wl-kuninori.morimoto.gx@renesas.com>
 <TYAPR01MB4544C2F924EA24C7F6394267D8110@TYAPR01MB4544.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYAPR01MB4544C2F924EA24C7F6394267D8110@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Morimoto-san and Shimoda-san,

Thanks for your feedback.

On 2020-02-18 00:11:03 +0000, Yoshihiro Shimoda wrote:
> Hi Niklas-san,
> 
> > From: Kuninori Morimoto, Sent: Tuesday, February 18, 2020 9:01 AM
> > 
> > Hi Niklas
> > 
> > > > +renesas@???
> > >
> > > I have not used the +renesas@ for my other entry in MAINTAINERS for
> > > R-Car VIN and wish them to be the same. I have do not mind if that is
> > > with or without the +renesas tag.
> > >
> > > @Shimoda-san: What would you and Renesas prefer I use?
> > 
> > Please use +renesas@ for Author when you post patches.
> > We don't mind for other mail address, like MAINTAINERS.
> 
> I have the same opinion with Morimoto-san.

Ok thanks, good to know my view align with yours.

Could one or both of you provide an Acked-by tag for this patch to bless 
it?

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > Thank you for your help !!
> > Best regards
> > ---
> > Kuninori Morimoto

-- 
Regards,
Niklas Söderlund
