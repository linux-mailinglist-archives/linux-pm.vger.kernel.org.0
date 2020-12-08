Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693402D2219
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 05:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgLHEaI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 23:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLHEaH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 23:30:07 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88ADC061794
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 20:29:27 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e2so2709865pgi.5
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 20:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nwo+BCJKm7wcb2h7JzOrNJu8zdED7/Pq3+KQEiGYNC4=;
        b=ftPp1aze2+o1I5P7qeC+WWQnUhOXYDB6WysEgSHwPTEqehGwSZ1nTTjWQTyLkuFyq2
         Bqd0dTz41+LZYiJ7059Wn/BGrqkvGUnKyzrigWLghh9z8SlrznCkiWM8k9HbSV9MWNu3
         FMT1LBU3JeswHBwQr539iJXFeULVSS9jodJCVFvx0zHOJjxcDNJrBXZchUj0n0SU6Dy7
         XMD3oZKlEULVQWlzWbneoJzhTWVNRA01G8muy6btZWGXiIqvoigvYoFgmCXCs7c33y28
         GACPaCMyvhJNKxqqpI535T8gXObq8RjiMJCTnb3TV+KH29hpkmuLyM/HUiAUZRaBOuTF
         gDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nwo+BCJKm7wcb2h7JzOrNJu8zdED7/Pq3+KQEiGYNC4=;
        b=muaUjxC1L8RSlxBs0AyiBshLsClnpexBNo42gZmXt4Rume+uPBcJsAhpsb9fGwGoYP
         9E/ge1ZuHMwFnQk4CtjtywHNJITUqifx8GWAk8p4wKRI25/9MEfzlaRYdrbQumx4+J99
         RhuOKuJzdb2Pt0KAPNtLoTvnbQAs6xcGAA8Hc2eJD4//8L6bfr9ACbHWi39SDnt78qjI
         396MkTXzXoL16Lgy+SXwWs+ScnH6fFXkzy4lfL0Rzh07fUburlnqvq0Aws3E9wfmwwbj
         7sZldZrscigMUc4phyvFi7iLmP6qH8gRahoIZkw1SiE5LA5vUHhSfiGQ+L+No2tmLu70
         c52Q==
X-Gm-Message-State: AOAM530PnLCI97/E+7OFv/2UD8jSBE9N4F9kLXziinlCiRpHkJZk1Qh0
        dcrMLqEsNPkh/HfjiDkV83b1Lg==
X-Google-Smtp-Source: ABdhPJw6cKmfJYM3CskGrGwpcWIdE9+O9nGA+xXmZktoCuvueP8ol/A7L8M41d+n06uF2Ug544ZyAA==
X-Received: by 2002:a17:90b:187:: with SMTP id t7mr1333182pjs.191.1607401767151;
        Mon, 07 Dec 2020 20:29:27 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id 193sm3853148pfz.36.2020.12.07.20.29.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:29:26 -0800 (PST)
Date:   Tue, 8 Dec 2020 09:59:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
Subject: Re: [PATCH v4 1/4] dt-bindings/opp: Update documentation for
 opp-shared
Message-ID: <20201208042924.kv7tqsbstoanqham@vireshk-i7>
References: <20201202172356.10508-1-nicola.mazzucato@arm.com>
 <20201202172356.10508-2-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202172356.10508-2-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Subject should rather be:

dt-bindings: opp: Allow empty OPP tables

On 02-12-20, 17:23, Nicola Mazzucato wrote:
> Currently the optional property opp-shared is used within an opp table
> to tell that a set of devices share their clock/voltage lines (and the
> opp points).
> It is therefore possible to use an empty opp table to convey only that
> information, useful in situations where the opp points are provided via
> other means (hardware. firmware, etc).
> 
> Update the documentation to remark this additional case and provide an
> example.
> 
> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 9847dfeeffcb..a5f1f993eab9 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -72,6 +72,9 @@ Optional properties:
>    switch their DVFS state together, i.e. they share clock/voltage/current lines.
>    Missing property means devices have independent clock/voltage/current lines,
>    but they share OPP tables.
> +  This optional property can be used without any OPP nodes when its only purpose
> +  is to describe a dependency of clock/voltage/current lines among a set of
> +  devices.

And instead of this, we should rather update "OPP nodes:" section like
this:

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 9847dfeeffcb..28077ce3a845 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -63,11 +63,13 @@ This describes the OPPs belonging to a device. This node can have following
 - compatible: Allow OPPs to express their compatibility. It should be:
   "operating-points-v2".
 
+Optional properties:
 - OPP nodes: One or more OPP nodes describing voltage-current-frequency
   combinations. Their name isn't significant but their phandle can be used to
-  reference an OPP.
+  reference an OPP. These are mandatory except for the case where the OPP table
+  is present only to indicate dependency between devices using the opp-shared
+  property.
 
-Optional properties:
 - opp-shared: Indicates that device nodes using this OPP Table Node's phandle
   switch their DVFS state together, i.e. they share clock/voltage/current lines.
   Missing property means devices have independent clock/voltage/current lines,

-- 
viresh
