Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7057F1E87BB
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 21:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgE2T03 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 15:26:29 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35270 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2T03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 15:26:29 -0400
Received: by mail-il1-f196.google.com with SMTP id a14so3640402ilk.2;
        Fri, 29 May 2020 12:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1fphpl7nvKvkI2a1IjtaQR5TbQP0T0Z3ag/hlQwA83w=;
        b=WhXKK5HKHUISGKv+UnClvscYrhbfKhL+zsyzO5ddLBOpaRjx1j9eU83x1bIQKSym6z
         C/J8hVlRpCn2Hw//mXWjc+uEi2qTjIPDR1IY7dNHdLMZfS5LPxrjYXJxqeUldTtwkzcH
         R7mDDJHOMpTXvYhYlnBOeI8Wpes7rJVXcul98UAesAnD2bzYFcIvEHnIM3GUBztroJoz
         TANilDbC41O9PlJdNdIzyyvOqnXZ4NvztQCdVY1YGdiiprKeKjTEwu+rdNkPEEdOvtPz
         CwasToOEhyQEnQ8hhA8Fs4FEhsoGAJHHJQly1AP+42zoqmFwXAGveu0uWErBS+Z2WaMa
         EOxQ==
X-Gm-Message-State: AOAM531iOtzyoCpy/XLCiMpgaY9kgeVVyzGLNWq9QjzcsjBccHLL8uc/
        R18dr/EaH5cOFmIbhUBXRw==
X-Google-Smtp-Source: ABdhPJx+36CA6rV3CjerRlAYBo6oT1IPD3MDk2fQIxDjsiR+YNzfH/Euhppr/AdpQAmUuZBR7kMehg==
X-Received: by 2002:a92:d4cf:: with SMTP id o15mr9168738ilm.49.1590780388036;
        Fri, 29 May 2020 12:26:28 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c11sm5441006ilg.20.2020.05.29.12.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:26:27 -0700 (PDT)
Received: (nullmailer pid 2798406 invoked by uid 1000);
        Fri, 29 May 2020 19:26:26 -0000
Date:   Fri, 29 May 2020 13:26:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-kernel@vger.kernel.org, sre@kernel.org,
        devicetree@vger.kernel.org, afd@ti.com, linux-pm@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: power: Add BQ28z610 compatible
Message-ID: <20200529192626.GA2797881@bogus>
References: <20200528122147.6171-1-dmurphy@ti.com>
 <20200528122147.6171-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528122147.6171-3-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 28 May 2020 07:21:46 -0500, Dan Murphy wrote:
> Add the Texas Instruments bq28z610 battery monitor to the bq27xxx
> binding.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
