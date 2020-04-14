Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2707B1A8E01
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 23:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440783AbgDNVtx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 17:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440749AbgDNVtr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 17:49:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC37C061A0E
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 14:49:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d77so14828600wmd.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lLu0lDjOuieHB5rYFFB3f7WiEo1gndmAxrF4xwTxJdI=;
        b=DhsWQxH8nmCAK1PslhefQsGiSmVRGPV2C48zxDbAw+oQWBdo9hCDs8vO1ONpqDN/ZZ
         0bz/HssycdFvoO7X3Iesav1WJkrV/TzZ8z1A2cYIFwxDLpmiHDaHFAWeW1CL6SPLhYmU
         lZHTH7t8+H+50T6hyqE/VczVZrP0k7Yam75JGCk4tqKGgVg/hd8f5PzicIVTsN8l8wf9
         0d7w2hKZQlina8KT9FJPENgYhD12ZaSSfJ9EFc5c82a/zaqtSwByCfK5H7WE/lt/S0RJ
         ZqXOLu6xUN/HVpfbnQ/0i/WvJqbIY+SX3vK/d/QuS5EuF4moAadgaBELrhQpbFEgXMGh
         noPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lLu0lDjOuieHB5rYFFB3f7WiEo1gndmAxrF4xwTxJdI=;
        b=BND5JW8t+pe4niqpcYUSu+1CsrhByV+mXioLVUcbHpE/++FCeeUSOaa0R32HP5EIlQ
         wfMsNnTtZD/IRfDHiJglNpmyplaBAqIqjYfzygCyHIHq3PmwS2Ft+av2omlSOmsP3vMy
         nUyJIYhpDS5oGbTYdFrC1vzzTlhWG8fhCkQ3j0xyhQ7sOSSjF+35hOL5VDOVFMRd0U3L
         QXMi09E1mmALSwtmd1jgEdkLgJL2AnJ50srn6J5/br+wwFawA/qCqtvuHsbSHkGZ78+S
         MQtbWI6a/ScO7RiFZJE8SJJWeI9WDC7LsltJZKHsKaw3TFHLZk4cV8bsO+um3yq3bPmP
         Ra6w==
X-Gm-Message-State: AGi0PuYoB3Z2VvVZxbdVqYZO5RajSREw2TAzuzxVbcsK1DvdEYOi24xM
        jHJFuKWGDiz1iugM/3skcN+11z3cmtA=
X-Google-Smtp-Source: APiQypL0+9U7VuiJ8stS+8CjpDdryFrogKFubugLUq0tYDBk79fADkOCK7EquRDegrfCnG/uugEJyQ==
X-Received: by 2002:a1c:1d4b:: with SMTP id d72mr1784657wmd.19.1586900985207;
        Tue, 14 Apr 2020 14:49:45 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id b4sm15868876wrv.42.2020.04.14.14.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 14:49:44 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] dt-bindings: thermal: Add the idle cooling device
To:     Rob Herring <robh@kernel.org>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200414162634.1867-1-daniel.lezcano@linaro.org>
 <20200414162634.1867-2-daniel.lezcano@linaro.org>
 <20200414214509.GA10673@bogus>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <882e9605-a2e6-1af8-26e3-b03f2a7bcb5e@linaro.org>
Date:   Tue, 14 Apr 2020 23:49:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414214509.GA10673@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/04/2020 23:45, Rob Herring wrote:
> On Tue, 14 Apr 2020 18:26:27 +0200, Daniel Lezcano wrote:

[ ... ]

> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/thermal/thermal-idle.yaml:  while scanning a block scalar
>   in "<unicode string>", line 39, column 20
> found a tab character where an indentation space is expected
>   in "<unicode string>", line 44, column 1
> Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/thermal/thermal-idle.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/thermal/thermal-idle.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> warning: no schema found in file: Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-idle.yaml: ignoring, error parsing file
> Makefile:1264: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
> 
> See https://patchwork.ozlabs.org/patch/1270492
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.

Sorry for that, I forgot to re-run the binding check and my editor is
automatically replacing spaces with tabs.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
