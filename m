Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E79F0D5D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 04:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfKFDwl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 22:52:41 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44936 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfKFDwl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 22:52:41 -0500
Received: by mail-ot1-f67.google.com with SMTP id c19so3550282otr.11;
        Tue, 05 Nov 2019 19:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qVL6/KdJU5CK3KGDry37q377IXjdSjsU4IwjB7ytqvU=;
        b=AOdIx3mGPHoOBVTbgrR3Ttjyc1KxVQ/dsXwYAAx6JfxXfqiTnLJL0dk/EGZlkVaAvy
         g0P9h7uY5VBXBFdJbB8aYblf8feoPB88INwQN10CnQwUQX9MzhIahs70KpMnS075qGmA
         FIHFIfcXvLRtXOFor5y0K/CeDeOqAa0M82/RkEHljwbcl3ViZ1Z04OD4EBvEYGZNhyP+
         CoWddgQU2Zl+C5cyMWKuGQXsv/YVEqOhaQJPF7tJxvVHI7GxNbRPYuoxnODMPt3xQeh/
         saURn0KKPUEvaPlcFzpV0Xp3qUDukwjA7z5qWjR+mxEYdY8qcm5uV8n4b4uBPlFtDjni
         OXPQ==
X-Gm-Message-State: APjAAAX+umnKDBiXH1i0rPFQu604ZSCndBbkAAzLjctnBHVXp8bhW2z6
        AyMD/+kR+naye2RgEr/gqg==
X-Google-Smtp-Source: APXvYqw9JKyWfFwQh0q+Ym9dD6boCstaS2iRfFy5rBdgL0cCxIbhhpjTpkl5RRvH3B5KqmWgf9RjNQ==
X-Received: by 2002:a9d:4604:: with SMTP id y4mr219841ote.10.1573012359179;
        Tue, 05 Nov 2019 19:52:39 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m205sm6483459oif.10.2019.11.05.19.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:52:38 -0800 (PST)
Date:   Tue, 5 Nov 2019 21:52:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH] dt-bindings: interconnect: Convert qcom,qcs404 to DT
 schema
Message-ID: <20191106035238.GA25559@bogus>
References: <20191030101555.10955-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030101555.10955-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 30 Oct 2019 12:15:55 +0200, Georgi Djakov wrote:
> Convert the qcom,qcs404 interconnect provider binding to DT schema.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom,qcs404.txt     | 45 -----------
>  .../bindings/interconnect/qcom,qcs404.yaml    | 77 +++++++++++++++++++
>  2 files changed, 77 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
> 

Applied, thanks.

Rob
