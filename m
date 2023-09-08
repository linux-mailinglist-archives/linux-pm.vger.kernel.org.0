Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C02798B8A
	for <lists+linux-pm@lfdr.de>; Fri,  8 Sep 2023 19:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbjIHRhq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Sep 2023 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245454AbjIHRhq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Sep 2023 13:37:46 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E361FDB;
        Fri,  8 Sep 2023 10:37:32 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 14557863F9;
        Fri,  8 Sep 2023 19:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694194645;
        bh=fV75CFdSwk0QFGDW4psXe139ftn7RRV63AOiXjY71Vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ur8epBG54tdJuoviKdka3d4m2KPJWNb8ZvJLNDcFncUVh9UtSKcIRz5MUlhS4RlPu
         mJU1BhNVZUOQG2goeRgZg77fP/ccjujdT4Zqg6Pf0L56+EGs8cx5mNqeA8v3NzI9Xe
         snVcsR0+diOKE2TbxZV82Lnx1v11eBwhQKNnjXVjwMMzjy0LKfdAR4J8twP2X0n3ZC
         X5rWs/6Gbln4ajTHmpHuCkrL3QBwebBwhMrLCLnSFKjr42f6OiEaRydrQRXGDx9pJX
         Gahl2Y62uDkJUTYuA0I86ILtMiOyqSx05yjl30ZoGoAVu5q8gJ01YgYrnWCZAqtmdD
         mcfPzla8kGhSw==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 Sep 2023 14:37:25 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 1/3] dt-bindings: thermal-zones: Document
 critical-action
In-Reply-To: <CAJZ5v0jKmxxFMO5TkHujEtdSjeEqKqEOwRyXAXbaeRQUTythdg@mail.gmail.com>
References: <20230831130242.2290502-1-festevam@gmail.com>
 <CAJZ5v0jKmxxFMO5TkHujEtdSjeEqKqEOwRyXAXbaeRQUTythdg@mail.gmail.com>
Message-ID: <18b23d536827559f113ebae99c859cfc@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 07/09/2023 13:23, Rafael J. Wysocki wrote:

> So one more question here: Why is this a property of a thermal zone
> and not the property of the whole system?
> 
> Presumably, on a system where the platform integrator prefers to
> reboot on critical temperature, it would be necessary to add this
> property to every thermal zone.
> 
> Also, what if this property has different values for different thermal 
> zones?

I got your point and I can make the 'critical-action' property to be 
valid
for the whole thermal system.

Originally, I have been doing like this:

	thermal-zones {
		cpu-thermal {
			critical-action = "reboot";
			polling-delay-passive = <250>;
			polling-delay = <2000>;
			thermal-sensors = <&tmu>;

			trips {
				cpu_alert0: trip0 {
					temperature = <85000>;
					hysteresis = <2000>;
					type = "passive";
				};

I can change it to be:


	thermal-zones {
		critical-action = "reboot";

		cpu-thermal {
			polling-delay-passive = <250>;
			polling-delay = <2000>;
			thermal-sensors = <&tmu>;

			trips {
				cpu_alert0: trip0 {
					temperature = <85000>;
					hysteresis = <2000>;
					type = "passive";
				};

Thanks,

Fabio Estevam
