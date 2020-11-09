Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1327E2AC07E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 17:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgKIQHk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 11:07:40 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46356 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgKIQHk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 11:07:40 -0500
Received: by mail-ot1-f65.google.com with SMTP id g19so9391889otp.13;
        Mon, 09 Nov 2020 08:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wl+eg2VZccrg0Qat3l8zqj7949X5nB65JyVfX4x8H3w=;
        b=MS4puLDQRVSg4o63cyg+0P0f3jzrtFE79KoXBDjs/C+q4Shjy40KTJmrBLCelkj01L
         SioldE2MX98K9qq8ptYx1C43nmg7Lx73762jKTzpJYPssx0zP/VgXTnFJ8hbKod+FNIa
         JJEtyi5xq+7OYZ/0Juq8v7x1nkAIb5xnSyIxjP79bNxQml3uY7H4AmXlpkqBXHW0LfPK
         u9H1g5a7nyxOwU33YOvdtWQQnJ3uJNh+/nXybDc+6oj3AJWDMVhmUVukpVZ8BliDLs5F
         Rqv1/3jT22zsZnbLPNcsf+V9Cc9r2yhk4rtt3uhbL4wa6XujdKR6Y2VOvDPPrkqECln6
         zTIA==
X-Gm-Message-State: AOAM532M9MGU+VbqGMAJFwURjQGmwGKyHewTngKpOI9kOTREwgMTcK1H
        70UymU0vrZXWC+j1HZG4Cw==
X-Google-Smtp-Source: ABdhPJyQMzS871G4Spg4tIzcHvS5D15p/CoyoX4vkMxrd9bHDwbRzKn8uTbCqErsbcSuln3XvGzuEw==
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr10881779otk.275.1604938059184;
        Mon, 09 Nov 2020 08:07:39 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y35sm2601629otb.5.2020.11.09.08.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:07:38 -0800 (PST)
Received: (nullmailer pid 1375401 invoked by uid 1000);
        Mon, 09 Nov 2020 16:07:37 -0000
Date:   Mon, 9 Nov 2020 10:07:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     gene_chen@richtek.com, linux-pm@vger.kernel.org, sre@kernel.org,
        robh+dt@kernel.org, shufan_lee@richtek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, matthias.bgg@gmail.com,
        benjamin.chao@mediatek.com, Wilma.Wu@mediatek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add bindings document for
 Charger support on MT6360 PMIC
Message-ID: <20201109160737.GA1375361@bogus>
References: <1604400091-14618-1-git-send-email-gene.chen.richtek@gmail.com>
 <1604400091-14618-2-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604400091-14618-2-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 03 Nov 2020 18:41:30 +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add bindings document for Charger support on MT6360 PMIC
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  .../bindings/power/supply/mt6360_charger.yaml      | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
