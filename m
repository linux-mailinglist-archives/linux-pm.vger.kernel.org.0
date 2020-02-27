Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA9E172AAE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 23:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgB0WBW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 17:01:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38238 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgB0WBW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 17:01:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id e25so900342edq.5
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 14:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBxG5p3NtRm8vJZ9SrWGbyvBMMrZfbcd6sEkh872Wpk=;
        b=J2HlgJvotRvArCBanF+nmCfWdRF8pDW66BdmQms7zfNgyS7lRauYT3bDS5OboDi2DM
         ifdOo7gJ8d+ZZyQcHW2Fg38xWkUDpHzNNzVJKJHCx5P3h/fPWvAmbJsxP/jGHk9JHs8h
         efR20upDTYOd5dbP0XxRZK/5y/3u0AYyvc+eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBxG5p3NtRm8vJZ9SrWGbyvBMMrZfbcd6sEkh872Wpk=;
        b=tZIhr2f93Iz3Og681chMdnXxA/xiwwlwxsKMBGvN9sSYeRH3pqcA6JealnqHxZtuz2
         5SKkD+U8FkPWDtk1QsuT0hmBWlXPlwfHcKfMdYm9YFHGhkOWh4mcyw2h1S2heuYWTrbF
         eUELvv+9fdBK3qjICqG+JrTI2lkyqrf9NX/CROQIKhKOsWJ16y40/0le974KQ/K2lCNi
         CoIOBosLZPep3qlpz/0dUBuQa++S/4n1hrNFZyL+J325WA8xh1i4j+26UYNo05jOomaY
         34tp6AWRb+GliIcBS/a6GADXhNIMcI8ayMXZYHs8IHdgP6ylqgsxozbNiPmkprZhUStg
         SjXQ==
X-Gm-Message-State: APjAAAV0MJ7UWO47cWzMAutG5iPcSDO/+uAZ2hHPLJ/uCWZMvtPjMWNw
        Ly7fVXa/ZbhiN6AYYzOunAYRbPx76qg=
X-Google-Smtp-Source: APXvYqwajB3Rdhw7VzS4plbwEZwxEaxtWgBq0NYvcvcxf876Ac/ERoI/qzsqzJSowwQUEzA8jtPLLw==
X-Received: by 2002:a17:906:4749:: with SMTP id j9mr1061295ejs.132.1582840880577;
        Thu, 27 Feb 2020 14:01:20 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id dc5sm452819edb.61.2020.02.27.14.01.19
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 14:01:19 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id dc19so865254edb.10
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 14:01:19 -0800 (PST)
X-Received: by 2002:ac2:5226:: with SMTP id i6mr725638lfl.99.1582840389628;
 Thu, 27 Feb 2020 13:53:09 -0800 (PST)
MIME-Version: 1.0
References: <20200209183411.17195-1-sibis@codeaurora.org> <20200209183411.17195-5-sibis@codeaurora.org>
In-Reply-To: <20200209183411.17195-5-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 27 Feb 2020 13:52:33 -0800
X-Gmail-Original-Message-ID: <CAE=gft5OOQVKe9ow2ApbEAjmgqRc05hHVxUi4os+4-gvpMh4Yg@mail.gmail.com>
Message-ID: <CAE=gft5OOQVKe9ow2ApbEAjmgqRc05hHVxUi4os+4-gvpMh4Yg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] interconnect: qcom: Consolidate interconnect RPMh support
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

On Sun, Feb 9, 2020 at 10:34 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Add bcm voter driver and add support for RPMh specific interconnect
> providers which implements the set and aggregate functionalities that
> translates bandwidth requests into RPMh messages. These modules provide
> a common set of functionalities for all Qualcomm RPMh based interconnect
> providers and should help reduce code duplication when adding new
> providers.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Assuming Georgi's comments get addressed:

Reviewed-by: Evan Green <evgreen@chromium.org>
