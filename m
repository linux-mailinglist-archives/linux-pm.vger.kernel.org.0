Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93BA7791FE
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 19:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfG2RXS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 13:23:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfG2RXR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 13:23:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56A5A206DD;
        Mon, 29 Jul 2019 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564420996;
        bh=8LBXeqCHLxzkhJ6fYk5Mwh6ZnoaN3oqy+XOaykDGmqY=;
        h=In-Reply-To:References:From:To:Subject:Cc:Date:From;
        b=aAWCrQDkMvbS08hacUds+Wf+sZde7i/RjMzE9sV/eQqHTqn5a3FmpvX9WT3xLxFGK
         oPZgYjtXx6TIZIT4i5EOInmnuRQZj/IsdkDO4wOLz3zWR9gSygToWFfqBVOE/l1/cJ
         J0ycq151dPs5hFhPEg0DYdb8ihwl1LdMl6zQpcFw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190726231558.175130-2-saravanak@google.com>
References: <20190726231558.175130-1-saravanak@google.com> <20190726231558.175130-2-saravanak@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: opp: Introduce opp-peak-KBps and opp-avg-KBps bindings
Cc:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Mon, 29 Jul 2019 10:23:15 -0700
Message-Id: <20190729172316.56A5A206DD@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Saravana Kannan (2019-07-26 16:15:55)
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentatio=
n/devicetree/bindings/opp/opp.txt
> index 76b6c79604a5..b1eb49d6eab0 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -83,9 +83,14 @@ properties.
> =20
>  Required properties:
>  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. Thi=
s is a
> -  required property for all device nodes but devices like power domains.=
 The
> -  power domain nodes must have another (implementation dependent) proper=
ty which
> -  uniquely identifies the OPP nodes.
> +  required property for all device nodes but for devices like power doma=
ins or

s/but/except/

> +  bandwidth opp tables. The power domain nodes must have another (implem=
entation
> +  dependent) property which uniquely identifies the OPP nodes. The inter=
connect
> +  opps are required to have the opp-peak-KBps property.
> +
> +- opp-peak-KBps: Peak bandwidth in kilobytes per second, expressed as a =
32-bit
> +  big-endian integer. This is a required property for all devices that d=
on't
> +  have opp-hz. For example, bandwidth OPP tables for interconnect paths.
> =20
>  Optional properties:
>  - opp-microvolt: voltage in micro Volts.
> @@ -132,6 +137,10 @@ Optional properties:
>  - opp-level: A value representing the performance level of the device,
>    expressed as a 32-bit integer.
> =20
> +- opp-avg-KBps: Average bandwidth in kilobytes per second, expressed as a

Shouldn't that be a lower case k? kBps?

> +  32-bit big-endian integer. This property is only meaningful in OPP tab=
les
> +  where opp-peak-KBps is present.
> +
>  - clock-latency-ns: Specifies the maximum possible transition latency (in
>    nanoseconds) for switching to this OPP from any other OPP.
> =20
> diff --git a/Documentation/devicetree/bindings/property-units.txt b/Docum=
entation/devicetree/bindings/property-units.txt
> index e9b8360b3288..ef4c4a199efa 100644
> --- a/Documentation/devicetree/bindings/property-units.txt
> +++ b/Documentation/devicetree/bindings/property-units.txt
> @@ -41,3 +41,7 @@ Temperature
>  Pressure
>  ----------------------------------------
>  -kpascal       : kilopascal
> +
> +Throughput
> +----------------------------------------
> +-KBps          : kilobytes per second

Same comment.

