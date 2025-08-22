Return-Path: <linux-pm+bounces-32886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF989B30F99
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 08:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B9316F41F
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 06:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C592E62DD;
	Fri, 22 Aug 2025 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EksWfMZl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBEA2E54C7
	for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2025 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845484; cv=none; b=RBUvainwIRCauNbBskAA0dD6Be9hl0LYvc5i3EolOzgrvSJk/ZEz9bMymDb4D7ZC3DxoIFlhoKUjSJ8UY13xOip9bm+1+1itpSnmUyyHlmcGprLWgiCXCGYQDtgUmU1k/fvZ9/X3sCOOHi3YLQ0nDOixivtTzmsbdohnDk2q0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845484; c=relaxed/simple;
	bh=w+fF5jilwCss3OzaglG2MI9XKzVq/OKDUeZWYv3d5Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7P03VXegMSJOfDJy958J0h4pwOX28g7dbP74bOWuzNVX4NnxEP3O6/xybQBUxjOUapZp/lcLkzN033mnQiY7JtTKTMXHhZ2fO9j7moOhyMgyleUX32M6++MSHbswgpJUIaYlng8shDNLwgyBVn1sYl4CwGWL53JHKdjydZK/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EksWfMZl; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b472da8ff0eso1162693a12.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 23:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755845481; x=1756450281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wnWlGVKFdFIBt1j22TCSqfwegODnyLKYBcy7SHn/za4=;
        b=EksWfMZlgr4e5ZZThYERWiBQ7aMeSuPlEUg2Lbwog/Po0WjlUTyewqcU0wAuE23gS0
         YaXbNNe3hoGrMgH9pE+x98EThdmcpXDbf4ZKlyClWmW7va0ThDh4ljLFhIyyGSl/lKkS
         okjFw0PmAnlvexeq6aeqFl5r5euYi+8FL20H9JAP4SD/M2pJQEXDaqVPo2UQMf0DyBaB
         shYCg8xsZn0xEyiqn3ZcbD8GQvp5GFvrnVuHcebM7j+Dow10jOmvA6zv7s0HHes3fKmn
         mFNNHJKJaCxP4txRNdhaGi5RyK/6O+P0K+CB0f0blNOnb96aSHRRerAq55B6tjUMPYt3
         x95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755845481; x=1756450281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnWlGVKFdFIBt1j22TCSqfwegODnyLKYBcy7SHn/za4=;
        b=XkjjYNgyo8UxTm5ULFOtTg913PAfIhzubf+0MJDi39oimaMqUK1zIbEPM13uF5zRR/
         W6U86fEa+wpcfnZWeIGtcbuD6hxTuGhh5on5BTbTiyaKC+0zXITT4oF3mm7GjfJOdJ4F
         VNo9f+13HyIVwceFyZR92oKpOWVxevOm0iwSUgbitjZN8jRdS7VdkZEh91asgm+3tazH
         SVwNevWxL6jyUJauF+F+neQrEYH/QhPTXhDbq4LKe8BScXuTg5j8Onqil2UmM7CcHyFc
         unTm9CszOlA8pkMdwhIAdnbdQMybhj2gPbCMj2H82xFRsFMbKAxtX/muKneFO0+RP2w4
         VThg==
X-Forwarded-Encrypted: i=1; AJvYcCVqy3Txmtp0+3Q4Sloz/UMBQqnCknQG0Th83Fk/IyQwnIMJtis0kgFvioegxvua+NmH3Ltu/LzucA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/EILrKDrTB0XpHC5h4Runc5Kq+S5+IQI4c6kis7sv++5pX9pO
	+qKu7SeEEzC1UPLce/0t8smxqlGlu7fupxzZag9OMO/JcucQU/e+oEW4JssSLqS0TDA=
X-Gm-Gg: ASbGncubZCbZ8ex7MDBPluz2qpTMuiAXPu2zgeBCgrYI3qEmSeN158QDh3573pca/Ym
	uDGEcce3xH4YVFA9bXG0y8g4/BGmIGMYN0ZI8bv5eeKadXPt5diAe3doCJFMdeYRuCOCSH1n2/l
	sDvdhrJXIVGQX6su+BHCUTlzZOQ/k4MnR0hYMz9UpM83JYbqUdLzSJW2uxIcXkNZpuVYS2Sa1l2
	Ifm7+sCbHURkDjzDd4KzTwWAeTcOvVkabU9mULEU/7jK6V+m+UgkR1lGKivc6GWsq1h8H+ZPSFz
	FSoQRFydy13Xx+4AkqDxSrYAKddJoLJxulOxPPbA33dMirPGqrCo4sSdNAPDp3UViPOQK30Il71
	JR7R0dLXH2EWhrn/1nw7aF+8y
X-Google-Smtp-Source: AGHT+IFuWz2fYkZGwCki5RHEZnzuVzd/HPxt47eh+hbJsFpZ62hbUXT2LVNh+1RDFwpb0mmLfChYMw==
X-Received: by 2002:a17:902:d607:b0:246:441f:f111 with SMTP id d9443c01a7336-246441ff47cmr14160665ad.43.1755845480880;
        Thu, 21 Aug 2025 23:51:20 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c7489sm74182225ad.70.2025.08.21.23.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:51:20 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:21:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/7] OPP: Move refcount and key update for readability
 in _opp_table_find_key()
Message-ID: <20250822065118.qktpqaudc2uhgzdm@vireshk-i7>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>

On 20-08-25, 13:58, Krishna Chaitanya Chundru wrote:
> Refactor _opp_table_find_key() to improve readability by moving the
> reference count increment and key update inside the match condition block.
> 
> Also make the 'assert' check mandatory instead of treating it as optional.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/opp/core.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Applied with:

@@ -554,8 +554,9 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
        list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
                if (temp_opp->available == available) {
                        if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
-                               /* Increment the reference count of OPP */
                                *key = read(opp, index);
+
+                               /* Increment the reference count of OPP */
                                dev_pm_opp_get(opp);
                                break;
                        }

-- 
viresh

