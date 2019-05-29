Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD272D416
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 05:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfE2DFr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 23:05:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36456 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfE2DFr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2019 23:05:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so435857pgb.3;
        Tue, 28 May 2019 20:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yae+joByYceDAtdWhJGQ+9TqNvlrFL7154XbmhADCzk=;
        b=loJI8CmBiDK4QXBglvOWt2m+NRvAhk4f5Dpdw5nuyIoVvwObyRmIIUVGmvd+FJfS/V
         ojqBViP2eZMFN4PrCjFp2vYaQP/xmsQowtHlPbbltDN9JTV/MQUAciCuFbIyOsUa62NC
         mT99NxZ1PC/nn6YWjHryuP+TmQUNFLHbDlidgSRKaGnUoexUoJM4CDsYz88VUbdqoT5X
         6wtYHSrpu4+CwzrqBfOvCvGZnImijdLv6e+on6dB3VxcHbH8DABwY7Zky1fnpEeDB2aF
         Cks3yYjP8tOWQbmD6QGz2QKW1VTSqye9kFjf0txnn8VNvPTFsPduE0rIuGIDpf1tVZ9z
         A3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yae+joByYceDAtdWhJGQ+9TqNvlrFL7154XbmhADCzk=;
        b=dhZmTmuL0Ijn3H/ew3LI5SFp5+Hta6Tr47CFc5DEntnP7PnyVaS3L55bH/sIARA/PC
         01Z5VFOaJDn6A/Of5x6en4ahuivWYfHOkcuJOLdyRjZoLzW1yX0CiwY6Dhe1zBC47xvD
         WwGfcUa6nTUdP2icaA/x5RkX5VPLU9cXC6Fq4pAZe9rsHyOXjoTTtkoG6WMoAJcBawWh
         +osyBVOATr66QcToxALUmgo/k2DSjwJHln4DXOB/scMKQyREqawoM5RlWVSPkIW91AeK
         FebhV3P8WBRBivey6RH4myc+N/m4VWkerIHS18iyz0GhehK489aDnYIISCZyNjpGayp8
         RMLA==
X-Gm-Message-State: APjAAAVg/wdbcLQYKI5rbTlEwazeGpZinkFwS/bDIuKeAqQ3uCIZGX95
        GngHE6GvmQY84FqW2SO8eJk=
X-Google-Smtp-Source: APXvYqyyAaMniytWmPWiZn/pkCsfkmPCIhT/hrGDPfJcVMyRDShfxmyDZOZFAswfsVwf7gqBNJ+SfQ==
X-Received: by 2002:a65:44cb:: with SMTP id g11mr134373637pgs.193.1559099146241;
        Tue, 28 May 2019 20:05:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id f10sm12830922pgq.73.2019.05.28.20.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 20:05:45 -0700 (PDT)
Date:   Tue, 28 May 2019 20:05:43 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH] thermal/drivers/of: Add a get_temp_id callback function
Message-ID: <20190529030542.GA2654@localhost.localdomain>
References: <20190416172203.4679-1-daniel.lezcano@linaro.org>
 <20190423154430.GA16014@localhost.localdomain>
 <bc10d520-4d15-74d6-0dc2-fd63df8d9a21@linaro.org>
 <ff407865-8606-60c2-62d8-60ae96d1984d@linaro.org>
 <CAHQ1cqG-cb=1hyO8oeV4k-6Pq4q+aqhH8RPx04i2oPTNhAhiVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqG-cb=1hyO8oeV4k-6Pq4q+aqhH8RPx04i2oPTNhAhiVg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 23, 2019 at 07:48:56PM -0700, Andrey Smirnov wrote:
> On Mon, Apr 29, 2019 at 9:51 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 24/04/2019 01:08, Daniel Lezcano wrote:
> > > On 23/04/2019 17:44, Eduardo Valentin wrote:
> > >> Hello,
> > >>
> > >> On Tue, Apr 16, 2019 at 07:22:03PM +0200, Daniel Lezcano wrote:
> > >>> Currently when we register a sensor, we specify the sensor id and a data
> > >>> pointer to be passed when the get_temp function is called. However the
> > >>> sensor_id is not passed to the get_temp callback forcing the driver to
> > >>> do extra allocation and adding back pointer to find out from the sensor
> > >>> information the driver data and then back to the sensor id.
> > >>>
> > >>> Add a new callback get_temp_id() which will be called if set. It will
> > >>> call the get_temp_id() with the sensor id.
> > >>>
> > >>> That will be more consistent with the registering function.
> > >>
> > >> I still do not understand why we need to have a get_id callback.
> > >> The use cases I have seen so far, which I have been intentionally rejecting, are
> > >> mainly solvable by creating other compatible entries. And really, if you
> > >> have, say a bandgap, chip that supports multiple sensors, but on
> > >> SoC version A it has 5 sensors, and on SoC version B it has only 4,
> > >> or on SoC version C, it has 5 but they are either logially located
> > >> in different places (gpu vs iva regions), these are all cases in which
> > >> you want a different compatible!
> > >>
> > >> Do you mind sharing why you need a get sensor id callback?
> > >
> > > It is not a get sensor id callback, it is a get_temp callback which pass
> > > the sensor id.
> > >
> > > See in the different drivers, it is a common pattern there is a
> > > structure for the driver, then a structure for the sensor. When the
> > > get_temp is called, the callback needs info from the sensor structure
> > > and from the driver structure, so a back pointer to the driver structure
> > > is added in the sensor structure.
> >

Do you mind sending a patch showing how one could convert an existing
driver to use this new API?

> > Hi Eduardo,
> >
> > does the explanation clarifies the purpose of this change?
> >
> 
> Eduardo, did you ever have a chance to revisit this thread? I would
> really like to make some progress on this one to unblock my i.MX8MQ
> hwmon series.

The problem I have with this patch is that it is an API which resides
only in of-thermal. Growing APIs on DT only diverges of-thermal from
thermal core and platform drivers.

Besides, this patch needs to document the API in Documention/

> 
> Thanks,
> Andrey Smirnov
