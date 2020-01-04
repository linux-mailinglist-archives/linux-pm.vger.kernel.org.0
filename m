Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDAD13050A
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 00:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgADXYf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Jan 2020 18:24:35 -0500
Received: from fgw20-4.mail.saunalahti.fi ([62.142.5.107]:14680 "EHLO
        fgw20-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbgADXYf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Jan 2020 18:24:35 -0500
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Jan 2020 18:24:34 EST
Received: from darkstar.musicnaut.iki.fi (85-76-82-2-nat.elisa-mobile.fi [85.76.82.2])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 1f4f40ca-2f47-11ea-826b-005056bd6ce9;
        Sun, 05 Jan 2020 01:08:30 +0200 (EET)
Date:   Sun, 5 Jan 2020 01:08:30 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Rob Herring <robh@kernel.org>
Cc:     Odelu Kukatla <okukatla@codeaurora.org>, georgi.djakov@linaro.org,
        daidavid1@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [V2, 1/3] dt-bindings: interconnect: Add Qualcomm SC7180 DT
 bindings
Message-ID: <20200104230830.GA27471@darkstar.musicnaut.iki.fi>
References: <1577782737-32068-1-git-send-email-okukatla@codeaurora.org>
 <1577782737-32068-2-git-send-email-okukatla@codeaurora.org>
 <20200104220142.GA28701@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104220142.GA28701@bogus>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Sat, Jan 04, 2020 at 03:01:42PM -0700, Rob Herring wrote:
> On Tue, Dec 31, 2019 at 02:28:55PM +0530, Odelu Kukatla wrote:
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> > new file mode 100644
> > index 0000000..487da5e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> > @@ -0,0 +1,155 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license new bindings:
> 
> (GPL-2.0-only OR BSD-2-Clause)

Just curious, is that mandatory for any new bindings?

A.
