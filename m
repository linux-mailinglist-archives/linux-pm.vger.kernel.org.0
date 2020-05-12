Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA11D0277
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 00:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgELWlP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 18:41:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33944 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgELWlP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 18:41:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id c12so18742456oic.1;
        Tue, 12 May 2020 15:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cr8pEezfGzmQ0Mn3r2/CPVqAGMkNpCECgIt4va/Dbb0=;
        b=mQBXNX70rsYyZz1H3yki/KE9uuoBxsrFX1ChwJQK8JMULs/qkPDxEpZzc3PQN/yHYA
         dTD7hwGS+XDjKKytIpEHe7CVtR20dIMxIa4l8Dybxgnerlx+f2A6Eik6dhsop/snfp3L
         vhniJa/zyOaFhTwAiw8kx5L52MlJdZAB3xaWTfWKk9OuLaqkOR6utA1tL8Un7FUOUelP
         2B3d1yca7VTJ94Oc9bPXmnN329Lli4YalUfqrqE9h49g6Z3ybWnxnzknIXyDTB2H/zrR
         eS0UKXVfW6jkL5YUUg1JP39Ue+oGMnRvGWsQvIP7i8TF/ciLcN07qb6M7wZg09iiyOWy
         i+Zw==
X-Gm-Message-State: AGi0PuYgK4TvagJjIRSNnEWf7R//54X0U43VFuAOtMM9Lge9Fgg0AAPJ
        qE7GTPmoneHnXY6pC2ILSA==
X-Google-Smtp-Source: APiQypJ2KQOzWEjBNgc6Ql69L7UqFeBqesWncTCUO9jKM4QP6iZAAHIdEhbt+VhqH5aV59DKlW73+g==
X-Received: by 2002:aca:fdd5:: with SMTP id b204mr26424284oii.167.1589323273009;
        Tue, 12 May 2020 15:41:13 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g30sm676838oiy.42.2020.05.12.15.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:41:12 -0700 (PDT)
Received: (nullmailer pid 4283 invoked by uid 1000);
        Tue, 12 May 2020 22:41:11 -0000
Date:   Tue, 12 May 2020 17:41:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sre@kernel.org
Subject: Re: [RESEND PATCH v3] dt-bindings: power: Convert bq27xxx dt to yaml
Message-ID: <20200512224111.GA4211@bogus>
References: <20200512191900.966-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200512191900.966-1-dmurphy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 12 May 2020 14:19:00 -0500, Dan Murphy wrote:
> Convert the bq27xxx.txt to yaml format
> 
> CC: Pali Rohár <pali@kernel.org>
> CC: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v3 - Added power supply reference to yaml, fixed the deprecated compatibles,
> I did not change any compatibles as discussed in the list these should come in
> separate patches - https://lore.kernel.org/patchwork/patch/1237912/
> 
>  .../bindings/power/supply/bq27xxx.txt         | 56 ------------
>  .../bindings/power/supply/bq27xxx.yaml        | 91 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
