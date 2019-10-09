Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79FDDD04A1
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 02:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfJIAMF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 20:12:05 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49261 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbfJIAMF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2019 20:12:05 -0400
Received: by mail-pl1-f202.google.com with SMTP id n18so371671plp.16
        for <linux-pm@vger.kernel.org>; Tue, 08 Oct 2019 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cNdhJyeG5GjZBd+aVbSImZd8WSDzEG5SHRL3gOPr830=;
        b=C2B+kKRxBmnboQ58DGVk4sq36JsCS6eLlr5yxMvcDGkQZQqR36FuEpUVDnKLBBTFhE
         2n8g2QXfc+4VQuaAgjo7mnb+mp3sjeNBCpuWXtwDkxo/p6x35jVJvdh8V12H7TUfCB6D
         CPurcGcVqslBeikqXcPleaeTfgH5rwnaVguteREmCA/AlarppMrGoUvTAeHpkLi+uUFV
         G/IEp2UiRc+4vnOP67GMbZb83jOxDKBxIfnJQoPmXwIbU4jgB9XRHTDGAgPCOUm+sOHx
         r5X0J/CPVhHhaFXfd9rqqgUjIts5xjH4nkb7F+KiXeF8iaDO7BFMefxUWl7Ey4jYm7+U
         1oaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cNdhJyeG5GjZBd+aVbSImZd8WSDzEG5SHRL3gOPr830=;
        b=X9aYaiUA42CdkZF3q5/+2/J4k8YCC9n8og9kLgOe4dYkDcZZdYMZdY9S8OwQplpMP0
         s6dtDsw2DRf+s98VQzaNPZy/Y3C0KmmutjVRfZuEQ/WYVbybyZDrnt3mfVcbUhtzy6wJ
         j8lHv4P5COmpLMAFFMwsqPQM5WV6mnTfBwdhPe5W1fae7BTYXgG1MyfebBTMXHBWDknl
         t0Z+7PXaeW0Xj9Q9k6G98VG3mPy75N2jzc+TWo6zv4ZbXkTfQTV7MRUKiL+tbMEpLfYX
         Stah4E/Dt3vXaQF3kMpojBz0xixLgkxjfmt7vV1kXFS1v2hlZWG5G3zX+tjyPRCgGBlP
         PBSw==
X-Gm-Message-State: APjAAAUN7yZ0DBVEO8Ea35PEZPEUF8d5QjmpzMBWSh+RYvm30VswKwJ3
        ayfWeTG2YB66AblJYGnvTGsCqPNUuave6V0=
X-Google-Smtp-Source: APXvYqzUwAUJ7ef6Z4sewmUfC6phFFrRCVw1qdTo+qrXYj7G3r0BMPlJ4k5A3b/HEGwE1y+5rQc91D/hZAbEt9Q=
X-Received: by 2002:a63:1609:: with SMTP id w9mr1270591pgl.184.1570579924013;
 Tue, 08 Oct 2019 17:12:04 -0700 (PDT)
Date:   Tue,  8 Oct 2019 17:11:59 -0700
In-Reply-To: <5d978bf9.1c69fb81.7b927.b6ac@mx.google.com>
Message-Id: <20191009001159.27761-1-saravanak@google.com>
Mime-Version: 1.0
References: <5d978bf9.1c69fb81.7b927.b6ac@mx.google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [RFC PATCH] interconnect: Replace of_icc_get() with icc_get() and
 reduce DT binding
From:   Saravana Kannan <saravanak@google.com>
To:     swboyd@chromium.org
Cc:     bjorn.andersson@linaro.org, daidavid1@codeaurora.org,
        devicetree@vger.kernel.org, evgreen@chromium.org,
        georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mripard@kernel.org, robh+dt@kernel.org,
        saravanak@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Stephen Boyd:
> Quoting David Dai (2019-09-27 10:16:07)
> > On 9/25/2019 6:28 AM, Stephen Boyd wrote:
> > > Quoting Bjorn Andersson (2019-09-24 22:59:33)
> > >> On Tue 24 Sep 22:41 PDT 2019, Stephen Boyd wrote:
> > >>
> > >>> The DT binding could also be simplified somewhat. Currently a path needs
> > >>> to be specified in DT for each and every use case that is possible for a
> > >>> device to want. Typically the path is to memory, which looks to be
> > >>> reserved for in the binding with the "dma-mem" named path, but sometimes
> > >>> the path is from a device to the CPU or more generically from a device
> > >>> to another device which could be a CPU, cache, DMA master, or another
> > >>> device if some sort of DMA to DMA scenario is happening. Let's remove
> > >>> the pair part of the binding so that we just list out a device's
> > >>> possible endpoints on the bus or busses that it's connected to.
> > >>>
> > >>> If the kernel wants to figure out what the path is to memory or the CPU
> > >>> or a cache or something else it should be able to do that by finding the
> > >>> node for the "destination" endpoint, extracting that node's
> > >>> "interconnects" property, and deriving the path in software. For
> > >>> example, we shouldn't need to write out each use case path by path in DT
> > >>> for each endpoint node that wants to set a bandwidth to memory. We
> > >>> should just be able to indicate what endpoint(s) a device sits on based
> > >>> on the interconnect provider in the system and then walk the various
> > >>> interconnects to find the path from that source endpoint to the
> > >>> destination endpoint.
> > >>>
> > >> But doesn't this implies that the other end of the path is always some
> > >> specific node, e.g. DDR? With a single node how would you describe
> > >> CPU->LLCC or GPU->OCIMEM?
> > > By only specifying the endpoint the device uses it describes what the
> > > hardware block interfaces with. It doesn't imply that there's only one
> > > other end of the path. It implies that the paths should be discoverable
> > > by walking the interconnect graph given some source device node and
> > > target device node. In most cases the target device node will be a DDR
> > > controller node, but sometimes it could be LLCC or OCIMEM. We may need
> > > to add some sort of "get the DDR controller device" API or work it into
> > > the interconnect API somehow to indicate what target endpoint is
> > > desired. By not listing all those paths in DT we gain flexibility to add
> > > more paths later on without having to update or tweak DT to describe
> > > more paths/routes through the interconnect.
> >
> >
> > I'm unsure that using the target device node or target source device is
> > the correct way to represent the constraints that the consumers apply on
> > the interconnects. While it's true the traffic is intended for the
> > targeted devices, the constraints(QoS or BW) are for the interconnect or 
> > specifically the paths that span across the ports of various
> > interconnects(NoC devices in this case). I think having both src and dst 
> > properties is still the simplest way to achieve the flexibility that we
> > require to set the constraints for ports(that may not have a target
> > device defined in DT or exists as some intermediate port across multiple 
> > interconnects).
> 
> 
> The need for paths described in DT may make sense for certain cases but
> that seems to be the minority. My guess is that maybe an OPP binding
> would need to describe the path to apply the bandwidth to. Otherwise I
> don't see what the need is for. Maybe you can list out more scenarios?
> 
> Either way, the binding has been designed to cover all the possibilities
> by just saying that we have to describe at least two points for an
> 'interconnect'. It is a path based binding. I'd rather see us have an
> endpoint based binding with the option to fallback to paths if we need
> to constrain something. Maybe this can be a new property that is used
> the majority of the time?
> 
> gpu@f00 {
>   interconnect-endpoints =3D <&icc GPU_SLAVE_PORT>, <&icc GPU_MASTER_PORT0>, <&icc GPU_MASTER_PORT1>;
>   interconnect-endpoint-names =3D "slave", "master0", "master1";
> };
> 
> (Or we can invert it and make interconnect-paths be non-standard)
> 
> The property would describe what's going to this device and how it's
> integrated into the SoC. This is similar to how we describe what port is
> connected to a device with the of graph binding or how we only list the
> clk or regulator that goes to a device and not the whole path to the
> root of the respective tree.
> 
> There can be a driver API that gets these port numbers out and
> constructs a path to another struct device or struct device_node. I
> imagine that 90% of the time a driver is going to request some bandwidth
> from their master port (or ports) to the DDR controller. We could either
> make the DDR controller a device that can be globally acquired or
> integrate it deeply into the API to the point that it looks for a DDR
> controller somewhere or relies on interconnect providers to tell the
> framework about the controller.
> 
> TL;DR is that I don't want to have to specify paths in each and every
> node to say that some port on this device here is connected to some port
> on the DDR controller and that we want to adjust the bandwidth or QoS
> across this path. I'd like to describe a device "hermetically" by
> listing out the ports the device has. Then we can rely on the OS to
> figure out what paths to construct and change. If we need to constrain
> or tweak those paths then we can do that with the existing interconnects
> binding, but let's worry about that when we get there.

I think I understand what you are trying to do here. Correct me if my
understanding is wrong. Each device just lists what interconnects (and their
ports) it's connected to -- let's call this device endpoints.

If a device is making bandwidth votes from itself to some other device, it just
specifies the other end point (as a device? path name?) in icc_get(). The
interconnect framework can then figure out what two interconnect ports the
icc_get() is about (by looking at the device endpoints info) and then construct
the path.

But it's not clear how you'll handle the case where a Device-A wants to make a
bandwidth vote from a Device-B to Device-C. This is necessary for multiple
scenarios. Eg: booting a remote proc where the CPU needs to make sure the
remote proc has its path to DDR active. icc_get() can't always assume the
source is the device making the request. So, I don't think you can omit the
source of the path in the DT binding.

If we take the above into account, would the only change in your proposal be to
list the source and destination device in DT instead of their interconnect and
ports?  I don't have a strong opinion on whether this is necessary, but want to
make sure that we are all talking about the same thing.

Another way to look at this: There's one crucial difference between clocks and
interconnects. Given a clock controller and it's "output port", the clock that
you referring to doesn't change irrespective of what device is asking for it.
But in the case of an interconnect, if you specify just a destination
interconnect and it's port, the path that you are referring to changes based on
which device is requesting it. And if you want a device independent of
referring to a path, you need to specify the source and destination explicitly.

Also, if a firmware isn't used, how do you see your icc_get() proposal working
with just the "name"? In what way is it better than the current icc_get() API?

Thanks,
Saravana
P.S: Sorry about any messy quoting/indentation. I'm hand editing the quoting
from the raw email text and using git to send a response.
