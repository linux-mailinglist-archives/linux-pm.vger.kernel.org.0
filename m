Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B258DC88
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 19:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfHNR7p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 13:59:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41722 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfHNR7p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 13:59:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so43120823pgg.8
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=kF2rSGg7TWdsph3+jKGWM5Z90AAtcPpo25Mf5csWFrU=;
        b=Zc/RhUNaKUH6TKfhRZWBo6OBqnN6wsyVNMAXjBgiNUtQxZoaGMZ+qifnZYFCHOtQNq
         93B6SETP1TqUWc7SCQ5mY3c3gtiWJs3r/RoBFb0OerUawl9ihfJgTVV4pxnTZyN7Uy7w
         41upxhquofjg2gVE6AG70o1y8XyTA+QyHCgLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=kF2rSGg7TWdsph3+jKGWM5Z90AAtcPpo25Mf5csWFrU=;
        b=bcao3V66BD4Y9BimSDZXXD6bA3AXk08BpkQ7QLFQj5hAb2Z1oc8OPAwzQGrTGUmxrs
         38GaOdV9MdIDMq//OmjsFoXlxFY6LK9wkL+40ZvSyw3kvYlTVGcV8N//MveU8wbcmjh+
         69ZcM0FWlsMUsCc9ZlGTFyuR8Kn3dfL04eE1rhl3XijL4t4xTUhel24NPWMylq1pY/L8
         sqrRIid1d9LedPTR97S86yTX9zIvLgoI+l/F/OvDWSzsGUFaVbsSl9gYVNxPfQHY0PZ2
         uYiMLukpcSDozVa4Q3g1aJDv+Jp6jvlhZAKucylmJK/WVHN9lqJb6TwEbzkQjxD1zSxY
         +Uog==
X-Gm-Message-State: APjAAAWADKOdaZnDM8ZUHkg958cZxpIGzuUZajKOe68tTNYyQ4vqzNfx
        drcc3e3og+35triTrgpeihQ9iA==
X-Google-Smtp-Source: APXvYqzlhFg/syHBm6u3NkrWSTkdwA/nnqbqnwh5uAmEwTa/NV7gwIbeSWeDmlMEvcDq5rUej/oTTg==
X-Received: by 2002:a17:90a:7d09:: with SMTP id g9mr903391pjl.38.1565805584194;
        Wed, 14 Aug 2019 10:59:44 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f72sm486217pjg.10.2019.08.14.10.59.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 10:59:43 -0700 (PDT)
Message-ID: <5d544c0f.1c69fb81.a78d3.1381@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190813082442.25796-2-mkshah@codeaurora.org>
References: <20190813082442.25796-1-mkshah@codeaurora.org> <20190813082442.25796-2-mkshah@codeaurora.org>
Subject: Re: [PATCH 1/4] drivers: qcom: rpmh: fix macro to accept NULL argument
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 10:59:42 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Maulik Shah (2019-08-13 01:24:39)
> Device argument matches with dev variable declared in RPMH message.
> Compiler reports error when the argument is NULL since the argument
> matches the name of the property. Rename dev argument to device to
> fix this.
>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Maybe this should have a Fixes tag? And the subject could be something
like "avoid shadowing local variables in macro"?

Reviewed-by: Stephen Boyd <swboyd@chromium.org>


