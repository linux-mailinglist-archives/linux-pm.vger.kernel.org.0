Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CC778DA54
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjH3SgE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 14:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245427AbjH3POj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 11:14:39 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F9BE8;
        Wed, 30 Aug 2023 08:14:34 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 16C8E863DD;
        Wed, 30 Aug 2023 17:14:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693408473;
        bh=v2cAEiv6fXMr0+QRThhisPn328qsks5KhTTSdjVXwKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uO1rCZZ/dIi3yn15jPe+VG36GXlnP4rCCNAeqtDHYSoOfwyk9v8gkeewDyUNnu7oy
         SC0ow90yBXOo6OkGoSBrsrWZlQO1PiaLnqz4r1CBqg06ykGZfFn/Y+kI4ZJ6OmE8RV
         0osjBnCETdHdc4sdUQoOI7hMrnEhd6c4PZICrW32CMSPhpes2wVEyb+GeeVwvybK9w
         4YlVDsGqgfg5uihIPq1sPGGzvsXguwkJWDk89OvChN5URAYj8qMPd471yM36WpJDQj
         WP5PFcKepenDvvseQBy59ySu+8aKlYiQs9bjeaCXO6tIRqTsXRgoTNv9PaOD+R6Flm
         awPlMWO/Kh6aw==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Aug 2023 12:14:33 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabio Estevam <festevam@gmail.com>, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: thermal-zones: Document
 critical-action
In-Reply-To: <CAJZ5v0gexPEV2M5kfgCEUti=EE+_oR+wUjRboo0Rh=fPfNeDew@mail.gmail.com>
References: <20230829194200.1901988-1-festevam@gmail.com>
 <CAJZ5v0hZR3WD+wMA6c-Gt86hM5oCRZDcSsYF4SrYTvT2HtQ=fQ@mail.gmail.com>
 <c5d72559-4a97-c865-e51e-855d2bc1edee@linaro.org>
 <CAJZ5v0gexPEV2M5kfgCEUti=EE+_oR+wUjRboo0Rh=fPfNeDew@mail.gmail.com>
Message-ID: <edd2bc8ea364959e89ed4c3d2cc11a1e@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 30/08/2023 10:54, Rafael J. Wysocki wrote:

> Well, as a matter of fact, it isn't, so I'm not sure where this is 
> going.
> 
> Bool definitely allows the property to be not present, which means
> that the default behavior is intended and this is all about overriding
> a known default behavior.

This devicetree property can be used on non-Linux environments, such as 
bootloaders.

Bootloaders may have different default behavior than Linux, so 
explicitly listing
"shutdown" or "reboot" make it clearer, independent of the OS.

Thanks
