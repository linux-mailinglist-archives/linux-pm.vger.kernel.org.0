Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E2D2D80A4
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 22:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405281AbgLKVNU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 16:13:20 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37452 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392323AbgLKVNH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 16:13:07 -0500
Received: by mail-oi1-f193.google.com with SMTP id l207so11436780oib.4;
        Fri, 11 Dec 2020 13:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kDEarIT6QtyZ9leo9UW3n9PcaYOZGBRD8Q7A2EVH/bk=;
        b=AE+wjKpAgFX4dk/uPSFnGjZGddJlbd35kt/n5WsuqY0x/lgVMLnAZrDkB7wgnUC0f6
         sD/WsRTORcFsUu/uSk6A0AS2ZctjO4oLJvW9j3jLxsLXUVVo7IbT398CaBvHN74lKJqX
         Z6guxEKXOBi/0scocf3DuLrIHvgWoNWyjpYBl/OWHN9sorrcv8eyDg8yc8vluQT6aoFQ
         BZSB3Bd1OrUVrY1R0pOiJCCc8kVWbcvKxOmaGJDR7lSJxxqjGZt6E5Hzjpbu7n3wum16
         EnIiUggwXYHhysebAmyKzkWYcnjWy+Z/2t4QrfoY8fPB49m5DkzLALfyj8kV+u2Ukv5Q
         my1g==
X-Gm-Message-State: AOAM531Ffr72aAz9mjqYquyZMpZmRw4txkIXOtVpTBJfhtwX7DC0OwFv
        1q4CA2CTiaNs5jEBJMjvRg==
X-Google-Smtp-Source: ABdhPJzqwk8wLvsKy9ZMUr39mu3rcViIH1BQblnHU+cgFQ7mmj3SP4h6lGTWuefOzrIYXDGsgZrdPQ==
X-Received: by 2002:a05:6808:96:: with SMTP id s22mr3204268oic.153.1607721146017;
        Fri, 11 Dec 2020 13:12:26 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 8sm2193586oii.45.2020.12.11.13.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 13:12:24 -0800 (PST)
Received: (nullmailer pid 953910 invoked by uid 1000);
        Fri, 11 Dec 2020 21:12:23 -0000
Date:   Fri, 11 Dec 2020 15:12:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Klein <michael@fossekall.de>
Cc:     linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 2/3] Documentation: DT: binding documentation for
 regulator-poweroff
Message-ID: <20201211211223.GA953171@robh.at.kernel.org>
References: <20201211151445.115943-1-michael@fossekall.de>
 <20201211151445.115943-3-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211151445.115943-3-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 11 Dec 2020 16:14:44 +0100, Michael Klein wrote:
> Add devicetree binding documentation for regulator-poweroff driver.
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  .../power/reset/regulator-poweroff.yaml       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
