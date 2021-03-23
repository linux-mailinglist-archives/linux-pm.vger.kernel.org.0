Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF373460A7
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 14:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhCWN6v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 09:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231835AbhCWN6e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 09:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616507913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YebnmwWX+S8ZQ3dG1hl6dO6C/gAGM4REm6CQsMnnO4g=;
        b=DhJDJTDZxUVmaGzKtXxnn6gNYkGbKWgQWiy/P13HORqbFpGXbSLU1j/tFkCFY7k6Tc8bEZ
        Io0jvbMJa3ug+oaTpR2BooAsp7zZQT/mIYcsg8KXP3XJyzfR3cfugPSqxlwaeX7i4UjgBx
        FdPuKktNJaMo6Egzs3akDP8wFKAbrs8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-7gBtRGxxNHS2niLUaOYj0A-1; Tue, 23 Mar 2021 09:58:30 -0400
X-MC-Unique: 7gBtRGxxNHS2niLUaOYj0A-1
Received: by mail-ed1-f72.google.com with SMTP id cq11so988900edb.14
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 06:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YebnmwWX+S8ZQ3dG1hl6dO6C/gAGM4REm6CQsMnnO4g=;
        b=mXYKDMJ9kL2LaLX1yFqHQQoKRz+EmuPavTGxTIHayLzyuTqattluN7ITo3QH6EOhFV
         TYOZVxLTjX18UEUyG5vP+ZufhOOu5EGcdFPI7s3sXvloauWGnlojnb9jvPJW1xE4KVGL
         vdVYE2+gq8aT29pgaMUm0VbQmwuO262t/SPGOUKTYdihyrzntFSMgD6jLUYqmBwzKfm/
         B0MXQcHv1AoacgZ8Q20iGa/mVtNLSBDcDylbSPQphIGHaYGpkbQeP/8hWIr+psVCtkq5
         0xdUqS/i6fCc+vRWk4rNi6JYNeRU34QXd5BuarNAkcQC6ZEEA1WgNoMtGxHNG07fdMA+
         dibg==
X-Gm-Message-State: AOAM530ZmljEdSgHIJId2NSy4FiOTkBTLEHp9nv58+6n2lCr4LbZQXZr
        8mkwvgd2/Z3m/I+6OtmwSXhPLYtT4n48MfA168Fp/qjikN2h2wwGlvLR18wlb+WL8UfaDOKGFlF
        rtgeMSmq/152wM0K2KAE=
X-Received: by 2002:aa7:d416:: with SMTP id z22mr4661370edq.239.1616507909742;
        Tue, 23 Mar 2021 06:58:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi17n1Ed1L2Y8zrgtV4br5V/LDTYPI5t79OE6dRqHFOg9CKjXNlgrCLmv/vO9kOBk+epuJtw==
X-Received: by 2002:aa7:d416:: with SMTP id z22mr4661358edq.239.1616507909578;
        Tue, 23 Mar 2021 06:58:29 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id l12sm12767773edb.39.2021.03.23.06.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 06:58:29 -0700 (PDT)
Subject: Re: [PATCH v3 2/8] MAINTAINERS: Add entry for devm helpers
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
 <eec1797734e3d080662aa732c565ed4a3c261799.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e064fdd7-b276-6732-16fe-2eb2564b2179@redhat.com>
Date:   Tue, 23 Mar 2021 14:58:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <eec1797734e3d080662aa732c565ed4a3c261799.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 3/23/21 2:56 PM, Matti Vaittinen wrote:
> Devm helper header containing small inline helpers was added.
> Hans promised to maintain it.
> 
> Add Hans as maintainer and myself as designated reviewer.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Yes I did promise that, didn't I?  FWIW going this route is still
fine by me, assuming that having someone else maintain this makes
this easier on / more acceptable to Greg.

Ultimately this is up to Greg though, so lets wait and see what
Greg has to say about this.

Regards,

Hans



> ---
> Changelog from RFCv2:
>  - RFC dropped. No functional changes.
> 
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9e876927c60d..fa5ac3164678 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5169,6 +5169,12 @@ M:	Torben Mathiasen <device@lanana.org>
>  S:	Maintained
>  W:	http://lanana.org/docs/device-list/index.html
>  
> +DEVICE RESOURCE MANAGEMENT HELPERS
> +M:	Hans de Goede <hdegoede@redhat.com>
> +R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +S:	Maintained
> +F:	include/linux/devm-helpers.h
> +
>  DEVICE-MAPPER  (LVM)
>  M:	Alasdair Kergon <agk@redhat.com>
>  M:	Mike Snitzer <snitzer@redhat.com>
> 

