Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3DED9BAC
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 22:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbfJPUXF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 16:23:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33144 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfJPUXF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 16:23:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id i76so14964764pgc.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 13:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=Qrm1NvsXrsFrJaiaktnNZJoOxKRyRjdaoTo5U5Izuk8=;
        b=Ahh+DqSyKQU4I8H524JcL1PIUJqZCf9a35VJVicjcCCqn06nJAx24r1keCachP6WYS
         fk1t2w6sSlc2muk8MBj7Olqfe3BNATOJBd6R7srgvDSqvC26FQO6rIpRWqZRIGN/9neN
         7JZadWQ29Ssk8xRdKOzc/YlYYSJ/1raV59+DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=Qrm1NvsXrsFrJaiaktnNZJoOxKRyRjdaoTo5U5Izuk8=;
        b=k3Fw9EQHhd/OQlL9GWhPTyM1uYz3Pq0jA7zmYBfQ6BhaB/ReN6AJMr/XbHHmDt35lM
         dfXZKS8HMK/jL5/mV5ffh/fRSpmlnZjJwKKICSWfCGQfOuSNNPjVdsYlC62cBqWqziTW
         dALAr5UBCHlK95niATmAj9Ps7qZoQ0EjvUrS4AcT6SCp3r6vYLkh3Bo1AQy+oZctQVch
         aev60Wzgb9s0QVXoztQo/3cOkg4mvoPeoLBurcuicGpRa+iSZPlzQgq5WjKYzhh8YtIc
         BrElC3H4iv1trcMyMTlOTPSQ1SWd/5tiptirdGlcPxEvYIdeZuEZcRmGZEK8CCW68Mbp
         vC9w==
X-Gm-Message-State: APjAAAX/mGbm3j4xxKY/4zkFRJIcxXj8uvF3mk+x913tXMGwkQ1SLJFW
        qqnfs0zACYEV3c0SjeFL8nr58A==
X-Google-Smtp-Source: APXvYqyYjQEWTnhtfIJtx+HVP/qsBdKLByhTQ5WcY+ad6SCiP1cjGC6S1RKDWb2/HMy0APgi43ph6w==
X-Received: by 2002:a62:a104:: with SMTP id b4mr35615699pff.239.1571257384523;
        Wed, 16 Oct 2019 13:23:04 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p68sm33732397pfp.9.2019.10.16.13.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:23:03 -0700 (PDT)
Message-ID: <5da77c27.1c69fb81.b45e2.8b99@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191009001159.27761-1-saravanak@google.com>
References: <5d978bf9.1c69fb81.7b927.b6ac@mx.google.com> <20191009001159.27761-1-saravanak@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     bjorn.andersson@linaro.org, daidavid1@codeaurora.org,
        devicetree@vger.kernel.org, evgreen@chromium.org,
        georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mripard@kernel.org, robh+dt@kernel.org,
        saravanak@google.com, kernel-team@android.com
Subject: Re: [RFC PATCH] interconnect: Replace of_icc_get() with icc_get() and reduce DT binding
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 13:23:02 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Saravana Kannan (2019-10-08 17:11:59)
> Quoting Stephen Boyd:
> > The property would describe what's going to this device and how it's
> > integrated into the SoC. This is similar to how we describe what port is
> > connected to a device with the of graph binding or how we only list the
> > clk or regulator that goes to a device and not the whole path to the
> > root of the respective tree.
> >=20
> > There can be a driver API that gets these port numbers out and
> > constructs a path to another struct device or struct device_node. I
> > imagine that 90% of the time a driver is going to request some bandwidth
> > from their master port (or ports) to the DDR controller. We could either
> > make the DDR controller a device that can be globally acquired or
> > integrate it deeply into the API to the point that it looks for a DDR
> > controller somewhere or relies on interconnect providers to tell the
> > framework about the controller.
> >=20
> > TL;DR is that I don't want to have to specify paths in each and every
> > node to say that some port on this device here is connected to some port
> > on the DDR controller and that we want to adjust the bandwidth or QoS
> > across this path. I'd like to describe a device "hermetically" by
> > listing out the ports the device has. Then we can rely on the OS to
> > figure out what paths to construct and change. If we need to constrain
> > or tweak those paths then we can do that with the existing interconnects
> > binding, but let's worry about that when we get there.
>=20
> I think I understand what you are trying to do here. Correct me if my
> understanding is wrong. Each device just lists what interconnects (and th=
eir
> ports) it's connected to -- let's call this device endpoints.

Yes this is the ideal case.

>=20
> If a device is making bandwidth votes from itself to some other device, i=
t just
> specifies the other end point (as a device? path name?) in icc_get(). The
> interconnect framework can then figure out what two interconnect ports the
> icc_get() is about (by looking at the device endpoints info) and then con=
struct
> the path.
>=20
> But it's not clear how you'll handle the case where a Device-A wants to m=
ake a
> bandwidth vote from a Device-B to Device-C. This is necessary for multiple
> scenarios. Eg: booting a remote proc where the CPU needs to make sure the
> remote proc has its path to DDR active. icc_get() can't always assume the
> source is the device making the request. So, I don't think you can omit t=
he
> source of the path in the DT binding.

This is one scenario, not various scenarios. For a remote proc why
wouldn't we list the endpoint for the remote processor in the remote
proc node in DT? That makes sense to me so I'm not following this
scenario.

>=20
> If we take the above into account, would the only change in your proposal=
 be to
> list the source and destination device in DT instead of their interconnec=
t and
> ports?  I don't have a strong opinion on whether this is necessary, but w=
ant to
> make sure that we are all talking about the same thing.

What does this mean? I would assume that if device A is using another
device B, either that would be expressed in DT via a phandle property or
userspace would be connecting the two devices up with each other with
something like dma_buf so the driver would know the other side of the
path they want to scale bandwidth on.

>=20
> Another way to look at this: There's one crucial difference between clock=
s and
> interconnects. Given a clock controller and it's "output port", the clock=
 that
> you referring to doesn't change irrespective of what device is asking for=
 it.
> But in the case of an interconnect, if you specify just a destination
> interconnect and it's port, the path that you are referring to changes ba=
sed on
> which device is requesting it. And if you want a device independent of
> referring to a path, you need to specify the source and destination expli=
citly.

Yes but those are use-cases that don't need to be expressed in DT. We
should be able to get by with just listing the endpoints and then build
the layer in the kernel to get the other side of the endpoint if it's
something like DDR or another device that we want to connect the
endpoint to.

>=20
> Also, if a firmware isn't used, how do you see your icc_get() proposal wo=
rking
> with just the "name"? In what way is it better than the current icc_get()=
 API?

If there isn't firmware and we're using platform data then I imagine we
would have to have data tables listing out the endpoints of various
devices, endpoint names, and the device names associated with those
endpoints so we could match them up in the framework.

