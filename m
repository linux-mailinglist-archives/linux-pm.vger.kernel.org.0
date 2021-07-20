Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7C33CFAC6
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 15:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbhGTMzn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 08:55:43 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:43647 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239141AbhGTMyT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 08:54:19 -0400
Received: by mail-il1-f175.google.com with SMTP id w1so19107303ilg.10;
        Tue, 20 Jul 2021 06:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iXVXQCvX+rDxAmIhcemQIg3BD3R+OAgKkEeUeDAOaWU=;
        b=a+pAn7LxrDq+B3+ZhUOwd596Hs4hVs3kg19YlM2D/E0dz4O/MZwITyz/5ZsF6hnoL8
         KHS69rxuWzwwMQvwHFsZ7cXmAqnII0TlJmpqIzk+P1xvsKp5Y+6uw2Pj+KbXmJm1Z7Po
         +Ap0g3AGKYjHeN0+V0KWE+JXlz5E9o/s48UBv7EaXNvStfGvctRCVopAF6RlUspVHccv
         m271FV/cNrjfs9zwHtEaHcXZWp4b8kWnxMrCOEL869WdNSxE8bcS6g62xZ0MJjNoZZxS
         SQ5/PaE8V+rY57p6m2OoAvvqeofK/E/i28lEMn525cV/xeKksowbNjnxqbY0kh5YI3M8
         1EFg==
X-Gm-Message-State: AOAM5315wOdkCR6pksfdxihat4bHEVfICbW38MkdN5DG/Toqe14LrTmj
        fG0Xav//U6NoZrqLa5B67w==
X-Google-Smtp-Source: ABdhPJynuTGR01DW0qDQzAyJlxt9B4QibZ2YJFfotEtHfK6UrcGS8SIQSUwEVcONxP5BN2KDaz1dQg==
X-Received: by 2002:a92:ad04:: with SMTP id w4mr20381626ilh.221.1626788097223;
        Tue, 20 Jul 2021 06:34:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 10sm2014932iln.39.2021.07.20.06.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:34:56 -0700 (PDT)
Received: (nullmailer pid 4157543 invoked by uid 1000);
        Tue, 20 Jul 2021 13:34:54 -0000
Date:   Tue, 20 Jul 2021 07:34:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: opp: Convert to DT schema
Message-ID: <20210720133454.GA4147058@robh.at.kernel.org>
References: <20210719202732.2490287-1-robh@kernel.org>
 <20210720043108.bmoydy3a2r3gqhnq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720043108.bmoydy3a2r3gqhnq@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 20, 2021 at 10:01:08AM +0530, Viresh Kumar wrote:
> On 19-07-21, 14:27, Rob Herring wrote:
> > Convert the OPP v1 and v2 bindings to DT schema format. As the OPPv2 binding
> > can be extended by vendors, we need to split the common part out from the
> > "operating-points-v2" conforming compatible.
> > 
> > Cc: Yangtao Li <tiny.windzz@gmail.com>
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> > - move opp-peak-kBps next to opp-avg-kBps. Also add a dependency schema.
> > - Correct the opp-microamp schemas. It's always a single value for each
> >   regulator.
> > - Add missing type for '^opp-microamp-'
> 
> Applied. Thanks.

I found some issues with it, can you drop it? 

Rob

