Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525D210F7FC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 07:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfLCGoL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 01:44:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42374 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfLCGoL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 01:44:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id x13so1284008plr.9
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 22:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TtcC2GPbq3JBTNN9rECUNMmDwyrELwKzppI404mA1B0=;
        b=wRjMPOlBfADkyTJLJ+qfTIeQ+c1YuA/C4h8xlDGs/YxBgN3g+ZBMHvWYLx3fjV4fB4
         4fjdsYInTmt6mFQOn/KyVkGZe5FDxTEZ4KzgzipYgRLNpxSELJKO7p06y1Go2DoyU9Ne
         WgcSaHlmgKuZT3aMz342pryO0glR52VXfbX4KtrhpwwdXzoupO+qErSGLGhRdyJXKkj6
         pT9j58tveL1Ei7pmvv1oGAoCsHFkrEU5oWPEC6eXRC2Y7+WkzIkr1qfl0JkmhACl8DXC
         O8WLrIR6/vDsnrTr2EaLNP9i4z4/9CcBYPDV+ozWuSq9+kqJu5LFg8WjGOaZb1+R8zyu
         WJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TtcC2GPbq3JBTNN9rECUNMmDwyrELwKzppI404mA1B0=;
        b=EerW3Qxg7iZSl6ci+IV9IlYaLpaZu+6/FHZ3JxMb1HgO4PltDyQJVJGaqb3AG0gAr1
         wcx8zvT8+dwemsFA+WCCjWmDBD62L+GvUWF+ff3oDldpyKpVdz6nC3mM8TUyDg5z89dZ
         rmbX/vj79ZtGjDUS/RKuDcJ9lEw/NKrw8b+t94R+NRw7CbFHLnQP+OpccezufdBW/Icw
         23x/BlOS3fIs2/BMCi6l7FVOLgSsS9xUJOR8cF7TFmVeYzGmAMNLGsH+gzn2cDhhgV1J
         B6MvRWYWiM45rofKhpx3LiHwv4fV3JxPcrjZrbETqsowh9oits+28h/TLl0k6pkfalgX
         k/Cg==
X-Gm-Message-State: APjAAAWsp5zMbyfqRXNljYWsSVQpb3b+Ime7qNX9w4E9kyS8+VOVEFAi
        0kJv9UqSr7czTgNGXgB7IIeEyg==
X-Google-Smtp-Source: APXvYqzYR63Yw28c4/d7oAFcf009oytJ/A4hfebVb8UZjSFsWH61NqfDrwL11mFnOI8UwvyHTTEgLw==
X-Received: by 2002:a17:902:b702:: with SMTP id d2mr3488377pls.104.1575355450554;
        Mon, 02 Dec 2019 22:44:10 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id h4sm1398580pjs.24.2019.12.02.22.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 22:44:09 -0800 (PST)
Date:   Tue, 3 Dec 2019 12:14:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, rjw@rjwysocki.net, edubezval@gmail.com,
        linux-pm@vger.kernel.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/4] thermal/drivers/cpu_cooling: Add idle cooling
 device documentation
Message-ID: <20191203064407.ssw5cij5mlz5udg7@vireshk-i7>
References: <20191202202815.22731-1-daniel.lezcano@linaro.org>
 <20191202202815.22731-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202202815.22731-2-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-12-19, 21:28, Daniel Lezcano wrote:
> Provide some documentation for the idle injection cooling effect in
> order to let people to understand the rational of the approach for the
> idle injection CPU cooling device.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../driver-api/thermal/cpu-idle-cooling.rst   | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/driver-api/thermal/cpu-idle-cooling.rst

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
