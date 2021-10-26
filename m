Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4E343BC19
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 23:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbhJZVLO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 17:11:14 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:45666 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbhJZVLH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 17:11:07 -0400
Received: by mail-oi1-f172.google.com with SMTP id z126so432955oiz.12;
        Tue, 26 Oct 2021 14:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NdXK3HgVQA4wG/WIv8xw1PiMsq8Yo/IpQgy8pf9x8cc=;
        b=RVCSJ3kIngKrBc3vOykFlmToOuUJA3L7kGB0kK8iX9oYo57V4SiIy4MrhO7wPj0WNJ
         hcC3MMomVbiyNk1UzIUDNR6aicnr1GkKu/n1A3rKUz5zY3kJhuDSru6fgAM0+J02ol9M
         iFzJCWLvO04ujHpVONrRi1WHoihlteScKVp5Ua09Q3nqNNRiy3EpX7NOK7VEyseTT8td
         Oe/0cSsqO6iYLImDPOS9JeX4+hMewBdPairvWyyQJ3RcUh/4EOC7sY1VxPyGRYqJNuR3
         LBEF9mOTtGgYybjChJI6fEhfXJEiRzLBVaYzysp93sdazF7qsCe+wZpoUVU0rfVyxZ11
         S5ew==
X-Gm-Message-State: AOAM532dLTHCJltl7ArQNiWKSi15tRi1SpiUDiG8Ej4MMpMgarlrgljL
        u+rebUN/AW8PQUu6WV6H7Q==
X-Google-Smtp-Source: ABdhPJxpMg6g9+Q4FWWLYqlTpzb38jgJYimtMXdtH5tO0Yf+Nxl3zn/EL9erbhJya5/MpTAJsSqCog==
X-Received: by 2002:a05:6808:1246:: with SMTP id o6mr863920oiv.136.1635282522259;
        Tue, 26 Oct 2021 14:08:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o12sm4880729oti.21.2021.10.26.14.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:08:41 -0700 (PDT)
Received: (nullmailer pid 3252847 invoked by uid 1000);
        Tue, 26 Oct 2021 21:08:40 -0000
Date:   Tue, 26 Oct 2021 16:08:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     phone-devel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Stephen Boyd <sboyd@kernel.org>, Ilia Lin <ilia.lin@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: clk: qcom: msm8996-apcc: Add MSM8996
 Pro compatible
Message-ID: <YXhuWKZUyT1VqHSV@robh.at.kernel.org>
References: <20211014083016.137441-1-y.oudjana@protonmail.com>
 <20211014083016.137441-3-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014083016.137441-3-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 Oct 2021 08:32:04 +0000, Yassine Oudjana wrote:
> Add a compatible string for msm8996pro-apcc.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
