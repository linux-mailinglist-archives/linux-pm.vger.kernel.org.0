Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDA779FAC
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 05:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfG3D4b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 23:56:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40522 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfG3D4a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 23:56:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id b17so43650738lff.7;
        Mon, 29 Jul 2019 20:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53o7yb2lde/U7HEY2EiQ3SDljF6junXae0FASrSnDQU=;
        b=O+ntVxr3LzZJCCMpnzX9A8b3UZd9nQatTasdMI5cI2rBpR5kUCH3eMSVsjBwN1aY/M
         khKOiN2rSKkyEQsisPxlNp9H1Gypz2Vx71EKHEWbAQO3VFFbkbJvNSliVtBioSELoklt
         ZN6tqgUv2PIACskU9OGwM9q2xtg8jnDKNfeR4uRkeU0RoKRKropxeJoae2YtVsMjitjU
         G20jLSHTpHovu9KkWjgbe8pBzV8wxlAFxBBAS1vj1wcwaE1V7KP/05yOdS2HMaq05XTz
         1/g0UnX/DaPfudzLsY5kFFgZlE1UHj3sMX9Iuv7crhVXJOtrnDvqOp9CuQnyFXgYt6Ne
         Y8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53o7yb2lde/U7HEY2EiQ3SDljF6junXae0FASrSnDQU=;
        b=O+yUlk89tImjFGab4PV1NygM1QHFJcC53W+As0b5NXrQMP2EUzs+o9PGhN+R3oXAIC
         BCoBg2U3UDMcf9tKUH6VnRcczOZugB/RNvu+IRak6/HLvfdxs/K6d3MZMJtfaF+X63x1
         fNInCRtrddRuIoJvXLxamDVWe1RODxiM7TWFlT8dXurmwRG3dvJzPjtYzGHeY+MsLBMI
         PfRbBRh6LuEUfWfwnoZ+W7CVkfGqhl4xbm3KpUYHdv2YE0DZJdz7V4WrcY/WIHJg1DHP
         xPsaJv+jHCMHFvorMNKJ+BJQRVo7dDHsa+eQVN1cwjEoSrOtLlTNQml5mUc+IZVfrOH2
         tWUA==
X-Gm-Message-State: APjAAAWGQ5/DIP5aq4pfZpSIeSF+ovWS1EuxHAua/SewqPjOyDriHLTc
        S423Rj7VLgVSvqMGAxqFbB3rh2XFqLNsk0XdiDw=
X-Google-Smtp-Source: APXvYqz+hYmOjR1Q1FPSHEsNxBWcPa6R8P/w6lkdcVuTC5EHaVjHD41jQKSp06Sb288wCdnNJBU41kRPwCRaMehGWZY=
X-Received: by 2002:a19:5044:: with SMTP id z4mr51453777lfj.80.1564458988449;
 Mon, 29 Jul 2019 20:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190729083915.4855-1-Anson.Huang@nxp.com> <20190729083915.4855-4-Anson.Huang@nxp.com>
 <CAOMZO5AgP0BrHyFKz78rsEz1XQMgSNzMmtTV6Q+GYtCGBiFMEQ@mail.gmail.com> <DB3PR0402MB39161F938C25012015B9739CF5DC0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39161F938C25012015B9739CF5DC0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Jul 2019 00:56:33 -0300
Message-ID: <CAOMZO5D33zPEu8zkq-KYvDv4Xzd8OoshSbzOCrBw1hwwJr-qNg@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] thermal: qoriq: Add clock operations
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "rui.zhang" <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Anson,

On Tue, Jul 30, 2019 at 12:00 AM Anson Huang <anson.huang@nxp.com> wrote:

> Shawn already applied the patch, and Abel has the AHB clock patch to fix that,
> so just wait for the AHB clock patch in instead of revert the TMU clock patch?

Sorry, I don't understand Abel's patch as there is not a proper
description of what it tries to fix.

If I understand correctly Abel's patch is not the proper fix and the
real fix for the kernel TMU hang in linux-next is to manage the TMU
clock inside the TMU driver, like you did in this patch.

To avoid a revert one possible solution would be to send only this one
as a fix for 5.3. You can point that it Fixes the commit that adds
i.MX8M support for the TMU driver.
