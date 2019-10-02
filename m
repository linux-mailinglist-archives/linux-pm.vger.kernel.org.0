Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8AE9C8D4B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfJBPsY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 11:48:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36481 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBPsY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 11:48:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so7523621wmc.1;
        Wed, 02 Oct 2019 08:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IwKP6bZ0/M/GNRiVw0vgEg5C/Drz9g4f2GY67meqLWE=;
        b=I3BhUdD05maN4HlqZnHRXQv+3zKf0pTyiwmB4Mc06OW6G4rLDijaeWzUIJTBZIXoXb
         jxMYFmuz7Xq70ZnDTPscRPkOuKF3za0nwFObjAAeKyJAuP4NLtWcdTgjs0Nx4XRFDQnK
         DcwKmpmiYn+5p1xVo/uog+5Nm4pZ/BsyKvBijeU0w7XRAG5lnynUXlQSh4fHr76Yzq1+
         w1PbskxiX8xTZfaP1HXRGZ/0AzFVPcYn49SkXHKYgfAW8IkCUglqNNjZ8IwiuJx8/iit
         1m4fwtgfoOgc72Y/Us0BhJmM9PORr98twPReAS0t812R/qOMFi/B7b6EvDTtWdr4+K5/
         S+Tg==
X-Gm-Message-State: APjAAAVZzehGYvcvEo5z0yAWVmNUqBJEElGiu8lT72vCMcH0o8zg2tZi
        dNufGlvmnFiexUp5RMLsfqQ=
X-Google-Smtp-Source: APXvYqxeZ2BmgRha6QvpGjz+C0CN04lAeTAC36faPuMfUtJeANX0YHIp1xp1+lIX7zNyzHcuV9uAvQ==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr3638645wmd.14.1570031302235;
        Wed, 02 Oct 2019 08:48:22 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id o1sm3159082wrs.78.2019.10.02.08.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 08:48:21 -0700 (PDT)
Date:   Wed, 2 Oct 2019 17:48:19 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>, vireshk@kernel.org,
        robh+dt@kernel.org, kgene@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH v4 2/6] dt-bindings: samsung: Update the CHIP ID binding
 documentation
Message-ID: <20191002154819.GA4072@kozik-lap>
References: <20190910123618.27985-1-s.nawrocki@samsung.com>
 <CGME20190910123637eucas1p26d2051f9bdd1bdf4510f1908ea98f641@eucas1p2.samsung.com>
 <20190910123618.27985-3-s.nawrocki@samsung.com>
 <20190917181322.GA683@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190917181322.GA683@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 17, 2019 at 01:13:22PM -0500, Rob Herring wrote:
> On Tue, 10 Sep 2019 14:36:14 +0200, Sylwester Nawrocki wrote:
> > This patch adds documentation of a new optional "samsung,asv-bin"
> > property in the chipid device node and documents requirement of
> > "syscon" compatible string.  These additions are needed to support
> > Exynos ASV (Adaptive Supply Voltage) feature.
> > 
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > ---
> > Changes since v3:
> >  - none
> > 
> > Changes since v2:
> >  - corrected patch summary line prefix, the patch moved in the
> >    sequence
> > 
> > Changes since v1 (RFC):
> >  - new patch
> > ---
> >  .../devicetree/bindings/arm/samsung/exynos-chipid.txt  | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Dear Sylwester,

This will create conflicts with conversion to dt-schema (already picked
up by Rob).

Can you convert this patch to dt-schema format and send it for Rob?

Best regards,
Krzysztof

