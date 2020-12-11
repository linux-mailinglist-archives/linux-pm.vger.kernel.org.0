Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8508F2D6E6F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 04:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395038AbgLKDTD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 22:19:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46550 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389850AbgLKDS1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 22:18:27 -0500
Received: by mail-ot1-f67.google.com with SMTP id w3so7031947otp.13;
        Thu, 10 Dec 2020 19:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kfvwe9beHtlsq1YXLkiZdsmLu+zO71RiHfl2J8FkPBA=;
        b=p+FY0oUIXK6xT5BiktnKEWuGmmanaVw/PzsD82u7zpxuzUr3Io7dqAqDoTEp/EYYRh
         Io7F1YRJUAu2b6fpPPFsyHgITzpZldVfszPiQlWdW6sMVDsnAAgA9AzIQOSaLJRfO0lr
         oP+DD8YnpupV+LmY7WAZuTTsMLaS2nUSsKZYpNXCDfH/tYrpaZ5H4qKlw+vd79MhlXdD
         BgpaCMkIHLOf7S298WINeuQOXxfd07BLBax56RMCoPKyF0lyhHc9CX7y5OMrWYoqL5zE
         u18wbzEZjGahGsNNU6sBdyD5I++4C31VAaKl3zeihDAS8bZCdWF4+bE2dHu1S28JwJi2
         jG/A==
X-Gm-Message-State: AOAM533dnfqQEEW2bW5oQs0ut9Q/6siNKSBJFz4F/KApeoLyzDeLvy0K
        LrKh4pbiv92X/eRqAc+v9Q==
X-Google-Smtp-Source: ABdhPJzJp0FBFHiIkcIlmYreddX0+j6f+yH1kXzb13PTxEy5Y4I6XtTn7fLUNUq6K4cUSwMOrKycYQ==
X-Received: by 2002:a05:6830:cf:: with SMTP id x15mr8290746oto.55.1607656665562;
        Thu, 10 Dec 2020 19:17:45 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w6sm1647698otm.54.2020.12.10.19.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:17:44 -0800 (PST)
Received: (nullmailer pid 3563007 invoked by uid 1000);
        Fri, 11 Dec 2020 03:17:43 -0000
Date:   Thu, 10 Dec 2020 21:17:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-actions@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v3 2/7] dt-bindings: mfd: Add Actions Semi ATC260x PMIC
 binding
Message-ID: <20201211031743.GA3562977@robh.at.kernel.org>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <fe0ab8ef20813a2623cd1e543b16bb21c5b63367.1607216141.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe0ab8ef20813a2623cd1e543b16bb21c5b63367.1607216141.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 06 Dec 2020 03:27:02 +0200, Cristian Ciocaltea wrote:
> Add devicetree binding for Actions Semi ATC260x PMICs.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
> Changes in v3 (according to Rob's review):
>  - Dropped the 'pwrc' and 'onkey' nodes
>  - Used a common 'reset-time-sec' property
> 
>  .../bindings/mfd/actions,atc260x.yaml         | 181 ++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
