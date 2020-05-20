Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D3F1DBD51
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgETSv0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 14:51:26 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:58327 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbgETSvZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 14:51:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590000685; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=iDZjJDD859EkBfV9Fuaq6zQVkAKwZb8CaDaTamqjkpI=;
 b=IJateHygL+v4wDNh1Cz61NolfIUU2rd/JztRQRkglzBiTXa26hxXStYgGUFt4bEg+1bCUbhs
 USyT/zRMOSVnfzXyUADAg4CM7GULi5jBKvJjDYvI424bC3L+aOpfOVlBtk4lPQokqAjEJ/PF
 wjVVXzTZRdFvUZbJAEvQttXTbU8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ec57c2462ee3a3497a7c6f0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 May 2020 18:51:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 47CCFC43395; Wed, 20 May 2020 18:51:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57FC7C433C8;
        Wed, 20 May 2020 18:51:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 May 2020 00:21:14 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 09/10] dt-bindings: interconnect: Add interconnect-tags
 bindings
In-Reply-To: <CAGETcx8+NZYT863ySLf6XvgLBm8PM_4euue2=zbDscgmDFh+7g@mail.gmail.com>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-10-georgi.djakov@linaro.org>
 <20200519185836.GA469006@bogus>
 <CAGETcx8+NZYT863ySLf6XvgLBm8PM_4euue2=zbDscgmDFh+7g@mail.gmail.com>
Message-ID: <3a392629be195fa6bebca18309efffab@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-05-20 01:27, Saravana Kannan wrote:
> On Tue, May 19, 2020 at 11:58 AM Rob Herring <robh@kernel.org> wrote:
>> 
>> On Tue, May 12, 2020 at 03:53:26PM +0300, Georgi Djakov wrote:
>> > From: Sibi Sankar <sibis@codeaurora.org>
>> >
>> > Add interconnect-tags bindings to enable passing of optional
>> > tag information to the interconnect framework.
>> >
>> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> > ---
>> > v8:
>> > * New patch, picked from here:
>> >   https://lore.kernel.org/r/20200504202243.5476-10-sibis@codeaurora.org
>> >
>> >  .../devicetree/bindings/interconnect/interconnect.txt        | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> > index 6f5d23a605b7..c1a226a934e5 100644
>> > --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> > +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> > @@ -55,6 +55,11 @@ interconnect-names : List of interconnect path name strings sorted in the same
>> >                        * dma-mem: Path from the device to the main memory of
>> >                                   the system
>> >
>> > +interconnect-tags : List of interconnect path tags sorted in the same order as the
>> > +                 interconnects property. Consumers can append a specific tag to
>> > +                 the path and pass this information to the interconnect framework
>> > +                 to do aggregation based on the attached tag.
>> 
>> Why isn't this information in the 'interconnect' arg cells?
>> 
>> We have 'interconnect-names' because strings don't mix with cells. An
>> expanding list of 'interconnect-.*' is not a good pattern IMO.

Rob,
Currently the interconnect paths
assume a default tag and only few
icc paths require tags that differ
from the default ones. Encoding the
tags in the interconnect arg cells
would force all paths to specify
the tags. I guess that's okay.


> 
> Also, is there an example for interconnect-tags that I missed? Is it a
> list of strings, numbers, etc?

Saravana,
https://patchwork.kernel.org/patch/11527589/
^^ is an example of interconnect-tag useage.

> 
> -Saravana

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
