Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2DCC172A83
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 22:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgB0Vxf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 16:53:35 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38847 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbgB0Vxf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 16:53:35 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so559434lfm.5
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 13:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TciHlSTKGVGSwBjPpE6GdszVZvGGFdsKopsqP1eqA44=;
        b=R9wmRG8Zsj0hupJPPywP6/bpn+fXxWpBBjyuLdxnZKe76Pvx+79KpCZfPuJ6m9zgIB
         83dRXWqAbdH8mdUA2m5R6w1L5Jt/Nectudrnnm3VTIY8OxyPthplqvxqfFcG5SmgXxwL
         hEhb8GB0mIoGzRzN/dD6W9G//QmE5GgVN2PmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TciHlSTKGVGSwBjPpE6GdszVZvGGFdsKopsqP1eqA44=;
        b=KD2/2g12v2q7Mh1MGFYtvmJYSeE++g1WajPfc/huCWZoTnbUMy/tEHNyyxDk8Z93Gf
         rFTojOxxgdWQmEcFOfg64kntq4rGTBrNS3eTxjUQVYfhEBduOBmcO5wNJhBNOYYF32NI
         ivNqXFkW7ZPmOwsPGLod13zR5imnp1ryuCQfn6EJo/qY+1NL/Az0bHjk1vKZpOHZT+kN
         vqqVMqvVQgnOzl6pclX7ZAHGZ1DIpMCCoVfn77uqN3fN4fxFJx9vqL1toLlK7xJymNFW
         Ju0QKsHzz22RGtsafvQ+ZTuiLCxy9PlLm8G6JAUCGxik7g+pLYR9L42Vuek1Vy6iVDXf
         JbaA==
X-Gm-Message-State: ANhLgQ0G/imgoEqJBRl6DnAJn4FsUWjjr8FyNtd4VmjvGcWjuRtoJ2Iz
        ctzjxevXpPLLPGiZ9trmMAgCPGZ48u4=
X-Google-Smtp-Source: ADFU+vsC8H6FQboonU3BeDyVNBD56rpBpcTu+kbs+xFHmWih9IfDN+JGCU21vYan7XrJi91hiyK0Kw==
X-Received: by 2002:a05:6512:1085:: with SMTP id j5mr196647lfg.183.1582840412633;
        Thu, 27 Feb 2020 13:53:32 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id f14sm3481877lfh.40.2020.02.27.13.53.31
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 13:53:31 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id e18so924995ljn.12
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 13:53:31 -0800 (PST)
X-Received: by 2002:a2e:8702:: with SMTP id m2mr734336lji.278.1582840410701;
 Thu, 27 Feb 2020 13:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20200209183411.17195-1-sibis@codeaurora.org> <20200209183411.17195-7-sibis@codeaurora.org>
In-Reply-To: <20200209183411.17195-7-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 27 Feb 2020 13:52:54 -0800
X-Gmail-Original-Message-ID: <CAE=gft5YrX9idSOgam5JR3m_R8OZ0ZG6KKe-w6GmtmxY83OPnQ@mail.gmail.com>
Message-ID: <CAE=gft5YrX9idSOgam5JR3m_R8OZ0ZG6KKe-w6GmtmxY83OPnQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] arm64: dts: sdm845: Redefine interconnect provider
 DT nodes
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Dai <daidavid1@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Feb 9, 2020 at 10:35 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Add the DT nodes for each of the Network-On-Chip interconnect
> buses found on SDM845 based platform and redefine the rsc_hlos
> child node as a bcm-voter device to better represent the hardware.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
