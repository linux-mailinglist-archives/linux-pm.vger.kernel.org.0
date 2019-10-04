Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51813CC262
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 20:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbfJDSOV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 14:14:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35906 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfJDSOU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 14:14:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23so4203828pgk.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2019 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=0IDOtQgHmElD8p5B2w+YjcptWdtlf5vVNP5fCQ18Cjw=;
        b=jSQrChLhcmVVMxN2vgpR1Q4UdZbgBNU+3E5G58XTneDBys4wlfUOE/GPLXVR6uhnZL
         C1ui8JAyehI+IdvfyllS9IV1T4aFagv+PAyy04d/FQwIS16exf2GNN1UZFS5Jb3XLE6c
         mrYnztcJZlAuKjskuh33FNmaFjfevzrjGaS1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=0IDOtQgHmElD8p5B2w+YjcptWdtlf5vVNP5fCQ18Cjw=;
        b=untu4ECeLxnoyp3xBw8pSJovyerB6+ro+3qmdLHLLOTL9epRXtnuuj8SPQyYRhN292
         dTvLdXWCZtDycVCXcVsgTOe3iymzn4uJUoByY8AFOxfQSqjWNt6pzHRaEeFlyS8PHVgg
         94jPPAaFA0cNE/ZuyGrUFr+tM7LxKAiBJl2z03UPxTfmSTtzo7rIoDEfqsYdFpM6n9Pt
         LcTvAnNpuQRupixxz6P/DSZEiM71fBVdQP+ANqnfGmW7Jmm6BZ/l03UYDWKYQ9UVxOCW
         Ad+1kQN1gqRiV3RwE/66o/PsrI/IkfyItImsRBRZNISxVyJdm98UJwOkzHdDz/moryY2
         ITnw==
X-Gm-Message-State: APjAAAVUlUTTxirOIt3AHnJaB/cxhpbLEvpzP+J+3StmBpmPEGHr9M6v
        qRcwhHkyBEW8cYmh1gGDPw8oHQ==
X-Google-Smtp-Source: APXvYqzXmG1bMyrx+EgqINn91jy469r0K12/xfrx1x9Ey0oZZUEtP/hNvIYFYGlkN+MklxIFvSurxQ==
X-Received: by 2002:a62:62c6:: with SMTP id w189mr18679300pfb.235.1570212858215;
        Fri, 04 Oct 2019 11:14:18 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i6sm10089700pfq.20.2019.10.04.11.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:14:17 -0700 (PDT)
Message-ID: <5d978bf9.1c69fb81.7b927.b6ac@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <91d09847-31ad-e238-d84d-f7e0e21c6ef1@codeaurora.org>
References: <20190925054133.206992-1-swboyd@chromium.org> <20190925055933.GA2810@tuxbook-pro> <5d8b6b8b.1c69fb81.14b36.c053@mx.google.com> <91d09847-31ad-e238-d84d-f7e0e21c6ef1@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Dai <daidavid1@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>
Subject: Re: [RFC PATCH] interconnect: Replace of_icc_get() with icc_get() and reduce DT binding
User-Agent: alot/0.8.1
Date:   Fri, 04 Oct 2019 11:14:16 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting David Dai (2019-09-27 10:16:07)
>=20
> On 9/25/2019 6:28 AM, Stephen Boyd wrote:
> > Quoting Bjorn Andersson (2019-09-24 22:59:33)
> >> On Tue 24 Sep 22:41 PDT 2019, Stephen Boyd wrote:
> >>
> >>> The DT binding could also be simplified somewhat. Currently a path ne=
eds
> >>> to be specified in DT for each and every use case that is possible fo=
r a
> >>> device to want. Typically the path is to memory, which looks to be
> >>> reserved for in the binding with the "dma-mem" named path, but someti=
mes
> >>> the path is from a device to the CPU or more generically from a device
> >>> to another device which could be a CPU, cache, DMA master, or another
> >>> device if some sort of DMA to DMA scenario is happening. Let's remove
> >>> the pair part of the binding so that we just list out a device's
> >>> possible endpoints on the bus or busses that it's connected to.
> >>>
> >>> If the kernel wants to figure out what the path is to memory or the C=
PU
> >>> or a cache or something else it should be able to do that by finding =
the
> >>> node for the "destination" endpoint, extracting that node's
> >>> "interconnects" property, and deriving the path in software. For
> >>> example, we shouldn't need to write out each use case path by path in=
 DT
> >>> for each endpoint node that wants to set a bandwidth to memory. We
> >>> should just be able to indicate what endpoint(s) a device sits on bas=
ed
> >>> on the interconnect provider in the system and then walk the various
> >>> interconnects to find the path from that source endpoint to the
> >>> destination endpoint.
> >>>
> >> But doesn't this implies that the other end of the path is always some
> >> specific node, e.g. DDR? With a single node how would you describe
> >> CPU->LLCC or GPU->OCIMEM?
> > By only specifying the endpoint the device uses it describes what the
> > hardware block interfaces with. It doesn't imply that there's only one
> > other end of the path. It implies that the paths should be discoverable
> > by walking the interconnect graph given some source device node and
> > target device node. In most cases the target device node will be a DDR
> > controller node, but sometimes it could be LLCC or OCIMEM. We may need
> > to add some sort of "get the DDR controller device" API or work it into
> > the interconnect API somehow to indicate what target endpoint is
> > desired. By not listing all those paths in DT we gain flexibility to add
> > more paths later on without having to update or tweak DT to describe
> > more paths/routes through the interconnect.
>=20
>=20
> I'm unsure that using the target device node or target source device is=20
> the correct way to represent the constraints that the consumers apply on =

> the interconnects. While it's true the traffic is intended for the=20
> targeted devices, the constraints(QoS or BW) are for the interconnect or =

> specifically the paths that span across the ports of various=20
> interconnects(NoC devices in this case). I think having both src and dst =

> properties is still the simplest way to achieve the flexibility that we=20
> require to set the constraints for ports(that may not have a target=20
> device defined in DT or exists as some intermediate port across multiple =

> interconnects).
>=20

The need for paths described in DT may make sense for certain cases but
that seems to be the minority. My guess is that maybe an OPP binding
would need to describe the path to apply the bandwidth to. Otherwise I
don't see what the need is for. Maybe you can list out more scenarios?

Either way, the binding has been designed to cover all the possibilities
by just saying that we have to describe at least two points for an
'interconnect'. It is a path based binding. I'd rather see us have an
endpoint based binding with the option to fallback to paths if we need
to constrain something. Maybe this can be a new property that is used
the majority of the time?

 gpu@f00 {
   interconnect-endpoints =3D <&icc GPU_SLAVE_PORT>, <&icc GPU_MASTER_PORT0=
>, <&icc GPU_MASTER_PORT1>;
   interconnect-endpoint-names =3D "slave", "master0", "master1";
 };

(Or we can invert it and make interconnect-paths be non-standard)

The property would describe what's going to this device and how it's
integrated into the SoC. This is similar to how we describe what port is
connected to a device with the of graph binding or how we only list the
clk or regulator that goes to a device and not the whole path to the
root of the respective tree.

There can be a driver API that gets these port numbers out and
constructs a path to another struct device or struct device_node. I
imagine that 90% of the time a driver is going to request some bandwidth
from their master port (or ports) to the DDR controller. We could either
make the DDR controller a device that can be globally acquired or
integrate it deeply into the API to the point that it looks for a DDR
controller somewhere or relies on interconnect providers to tell the
framework about the controller.

TL;DR is that I don't want to have to specify paths in each and every
node to say that some port on this device here is connected to some port
on the DDR controller and that we want to adjust the bandwidth or QoS
across this path. I'd like to describe a device "hermetically" by
listing out the ports the device has. Then we can rely on the OS to
figure out what paths to construct and change. If we need to constrain
or tweak those paths then we can do that with the existing interconnects
binding, but let's worry about that when we get there.

