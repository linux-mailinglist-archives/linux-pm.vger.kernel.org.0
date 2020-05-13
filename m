Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD85E1D04B2
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 04:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEMCQ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 22:16:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36084 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgEMCQ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 22:16:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id t3so12234100otp.3;
        Tue, 12 May 2020 19:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a2wqEiR2YO61/IM28RCF3k1La3GOe9RC7Vyta+XxUIs=;
        b=G3byAfV6OKO/eomHZKMG1s+l+Y9nS/419iAg+zq+C9co0zqosDk3pOG5cuHemuQV/x
         oLd9l+mpC5/urRI9Nj2qw3X0U/qnBOHaZT2MfIMl7ESsNdPVSNoibMTCog0cZGD57CCr
         Y3zNHffpvQrYAnmc+afDXNIUWx3id8I5oRWX6chl6UkvBAarEbV06PYRO+gLoN9Bu8Pl
         vDAoUXi2djm+l941J/cUDn0bNG8mvjP9eNncqpIInKqWLLf9/EhFwUfSOf6rQEanVAvb
         8bVgDb+i/WAqkBiBe91l06TC4NHrNcCQG9uDiNPQkYkWvD36M2BzYSshzoDnOeO5dnAA
         Ux6A==
X-Gm-Message-State: AGi0PubmxjWU7nT/pIR5jc5xaZEYnFJxk1rrqJsTJ0EjRJUl7+JoXjPe
        /ZXUEJOgmDtrutoXqsuoBQ==
X-Google-Smtp-Source: APiQypKRTpQwgp+rBKDYfr3vpom+3FfInuZDYIisAS2nc0jQdulhFvoyzkUjMKXdHprWZ80vJXQQuA==
X-Received: by 2002:a9d:7a8a:: with SMTP id l10mr18385009otn.302.1589336217276;
        Tue, 12 May 2020 19:16:57 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q68sm1400827ooa.29.2020.05.12.19.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 19:16:56 -0700 (PDT)
Received: (nullmailer pid 9003 invoked by uid 1000);
        Wed, 13 May 2020 02:16:55 -0000
Date:   Tue, 12 May 2020 21:16:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sre@kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: power: supply: Document
 maxim,rcomp-value for max17040
Message-ID: <20200513021655.GA8915@bogus>
References: <20200504221300.3153-1-xc-racer2@live.ca>
 <BN6PR04MB0660F4D09451AE8F1DB284D3A3A60@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660F4D09451AE8F1DB284D3A3A60@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon,  4 May 2020 15:12:59 -0700, Jonathan Bakker wrote:
> The rcomp value is a device-specific value for configuration based
> on specific chemistries.  There is no public documentation on how
> to tune it.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  .../devicetree/bindings/power/supply/max17040_battery.txt      | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
