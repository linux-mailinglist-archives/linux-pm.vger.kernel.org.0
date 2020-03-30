Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8102119816D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 18:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgC3QlZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 12:41:25 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41484 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC3QlV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 12:41:21 -0400
Received: by mail-il1-f195.google.com with SMTP id t6so12853990ilj.8;
        Mon, 30 Mar 2020 09:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jDfuhhERWwVfAbKzc8x+g9SF+940rxQHp6lOjQAHuEY=;
        b=RbTbwleaFJCW5sV9VsrZ2Tnd2BIwvdNVSZs19LZbMgvuvrIcIV78aTypiROmgCZ7n1
         9umb9YRrwda2kCS5uPt6UwQ1z1NvNVMqD9dMvVbXNztx1OIa8Bq2ySx92j+yT6lvqszB
         mLjBHwXHcF54v1rTPz52w79ry/AZQ6kShZsENYDhdrOTtG+aIyAMl3xU4MLWSIqUbDd5
         rH0hvrXt3rZ6Cb830x0jVUchL6Im6rWPJtBdrI87AvbGrXmOqgOkF8fU4Wy8DzZMBHrw
         /pdN1dXc1CmjQjH+7K5rRC90B3rNfoBq1xxxBcdCMSzN+TfEwC41QdbfFRQIkZr3YyxV
         OJbg==
X-Gm-Message-State: ANhLgQ3dJrT7azxdF+afEScOFVKucmnsu0N/FqRENcwA1aOPhjPQb7T6
        fcBruRnZUD88RRH4JalcgtgYjHQ=
X-Google-Smtp-Source: ADFU+vtNu7A4kYO+vAShE7oivplhqOHuKwbMDeuTJQGVkQBmFY43xB2YpR0sXSX5j/efP4WSVdXDgA==
X-Received: by 2002:a92:cb09:: with SMTP id s9mr11579810ilo.182.1585586480538;
        Mon, 30 Mar 2020 09:41:20 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m14sm5125967ilr.16.2020.03.30.09.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:41:19 -0700 (PDT)
Received: (nullmailer pid 14998 invoked by uid 1000);
        Mon, 30 Mar 2020 16:41:18 -0000
Date:   Mon, 30 Mar 2020 10:41:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH] dt-bindings: thermal: rcar-thermal: Convert bindings to
 json-schema
Message-ID: <20200330164118.GA14405@bogus>
References: <20200311163221.1761949-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200311163221.1761949-1-niklas.soderlund+renesas@ragnatech.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 11 Mar 2020 17:32:21 +0100, =?UTF-8?q?Niklas=20S=C3=B6derlund?=          wrote:
> Convert Renesas R-Car Thermal bindings documentation to json-schema.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  .../bindings/thermal/rcar-thermal.txt         |  78 ----------
>  .../bindings/thermal/rcar-thermal.yaml        | 139 ++++++++++++++++++
>  2 files changed, 139 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/rcar-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
> 

Applied, thanks.

Rob
